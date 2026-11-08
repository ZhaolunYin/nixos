# vim: set tabstop=2 shiftwidth=2 expandtab :
# Hermes Agent gateway as a NixOS system service (replaces services/openclaw.nix).
#
# Upstream module: github:NousResearch/hermes-agent -> nixosModules.default
# Docs: https://hermes-agent.nousresearch.com/docs/getting-started/nix-setup
# NixOS support is "Tier 2" (best effort): pin the flake input to a rev.
#
# flake.nix must pass the input to modules, exactly like `openclaw` today:
#   specialArgs = { inherit openclaw hermes-agent; };
# (otherwise: "module argument `hermes-agent` is not externally provided" ->
#  infinite recursion)
#
# ── Secrets ───────────────────────────────────────────────────────────────────
# Nothing secret lives in this file or in the nix store. The module merges
# /etc/hermes/env into $HERMES_HOME/.env (/var/lib/hermes/.hermes/.env) at every
# `nixos-rebuild switch`. Create it BEFORE the first rebuild:
#
#   sudo install -d -m 0755 /etc/hermes
#   sudo install -m 0600 -o root -g root /dev/null /etc/hermes/env
#   sudo sh -c 'cat >> /etc/hermes/env' <<'ENV'
#   TELEGRAM_BOT_TOKEN=123456:ABC...
#   TELEGRAM_ALLOWED_USERS=<your numeric Telegram user id>
#   WHATSAPP_ALLOWED_USERS=<your number, country code, no +, comma-separated>
#   ENV
#
# ── First-run checklist ───────────────────────────────────────────────────────
# 1. sudo systemctl stop openclaw-gateway   (one consumer per bot token / WA device)
# 2. create /etc/hermes/env (above)
# 3. nixos-rebuild switch --flake .#homelab
# 4. pair WhatsApp (QR, terminal >= 60 columns wide):
#      sudo -u hermes env HERMES_HOME=/var/lib/hermes/.hermes hermes whatsapp
# 5. sudo systemctl restart hermes-agent && journalctl -u hermes-agent -f
#
# ── Model ids ─────────────────────────────────────────────────────────────────
# `model` values must match what llama-server reports:
#   curl -s http://127.0.0.1:2001/v1/models | jq -r '.data[].id'
# llama-server must run with --jinja, otherwise tool calls come out as plain text.
{
  lib,
  config,
  hermes-agent,
  ...
}:

let
  llamaUrl = "http://127.0.0.1:2001/v1";
in
{
  imports = [ hermes-agent.nixosModules.default ];

  services.hermes-agent = {
    enable = true;

    # Puts `hermes` on PATH and exports HERMES_HOME system-wide so the CLI
    # shares sessions/skills/cron with the service (replaces openclaw-ctl).
    addToSystemPackages = true;

    environmentFiles = [ "/etc/hermes/env" ];

    # Non-secret only: this ends up in the world-readable nix store.
    environment = {
      # llama-server listens without auth; Hermes just wants a non-empty key.
      OPENAI_API_KEY = "none";
      WHATSAPP_ENABLED = "true";
      WHATSAPP_MODE = "bot";
      WHATSAPP_ALLOW_ALL_USERS = "false";
    };

    settings = {
      model = {
        provider = "custom";
        base_url = llamaUrl;
        default = "gemma-4-26B-A4B-uncensored";
        # Hermes needs >= 64k context.
        context_length = 65536;
      };

      # OpenClaw's fallbacks list, same order. Fires on provider errors.
      fallback_providers = map (m: {
        provider = "custom";
        model = m;
        base_url = llamaUrl;
      }) [
        "qwen3.6-35B-A3B"
        "qwen3.8-flash-next-uncensored"
        "lfm2.5-24B-A2B-uncensored"
      ];

      # OpenClaw denied exec/process/read/write/edit/apply_patch/browser/plugins
      # in group chats. Hermes sets tools per platform, not per group, so this is
      # applied everywhere: read-only research (web search/extract, vision,
      # image gen) plus memory, session search and todo. No terminal, no file
      # writes, no code execution, no browser.
      # To get full tools back in DMs, replace with: [ "hermes-cli" ]
      toolsets = [
        "safe"
        "memory"
        "session_search"
        "todo"
      ];

      # groups."*".requireMention = false in OpenClaw: respond to every message.
      telegram.require_mention = false;
    };
  };

  # The agent talks to llama-server for every turn, so order behind it.
  systemd.services.hermes-agent = {
    after = lib.optionals config.services.llama-cpp.enable [ "llama-cpp.service" ];
    wants = lib.optionals config.services.llama-cpp.enable [ "llama-cpp.service" ];
  };
}
