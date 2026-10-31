# vim: set tabstop=2 shiftwidth=2 expandtab :
# OpenClaw gateway as a systemd system service.
#
# Upstream module: github:openclaw/nix-openclaw -> nixosModules.openclaw-gateway
# It renders services.openclaw-gateway.config to /etc/openclaw/openclaw.json and runs `openclaw gateway --port <port>` as the `openclaw` system user. Channel docs: https://docs.openclaw.ai/channels/telegram/setup
#
# ── Secrets ───────────────────────────────────────────────────────────────────
# Nothing secret lives in this file or in the nix store. The gateway reads
# /etc/openclaw/env (root:root 0600, hand-maintained, survives `nixos-rebuild`):
#
#   sudo install -m 0600 -o root -g root /dev/null /etc/openclaw/env
#   sudo sh -c 'cat >> /etc/openclaw/env' <<'ENV'
#   # token from @BotFather (no trailing comments: systemd keeps them in the value)
#   TELEGRAM_BOT_TOKEN=123456:ABC...
#   ENV
#
# The `-` prefix in EnvironmentFile means "optional": the service still starts
# before the file exists, Telegram just stays offline.
#
# ── First-run checklist ───────────────────────────────────────────────────────
# 1. put TELEGRAM_BOT_TOKEN in /etc/openclaw/env
# 2. nixos-rebuild switch --flake .#homelab
# 3. approve the first Telegram DM (pairing mode):
#      sudo openclaw-ctl pairing list telegram && sudo openclaw-ctl pairing approve telegram <CODE>
# 4. sanity check: sudo openclaw-ctl channels status --probe
#
# ── Model ids ─────────────────────────────────────────────────────────────────
# `models.providers.llamacpp.models[].id` must match what llama-server reports:
#   curl -s http://127.0.0.1:2001/v1/models | jq -r '.data[].id'
{
  pkgs,
  lib,
  config,
  openclaw,
  ...
}:

let
  cfg = config.services.openclaw-gateway;

  secretsFile = "/etc/openclaw/env";
  backupDir = "/var/backups/openclaw";

  # Runs the openclaw CLI against the *service's* config/state instead of
  # ~/.openclaw, so pairing and status probes hit the systemd unit.
  # writeShellScriptBin rather than writeShellApplication: the script sources a
  # runtime file, which nixpkgs' strict shellcheck gate refuses.
  #
  # runuser (not sudo): sudo's env_reset would strip the variables sourced from
  # secretsFile, so `channels status --probe` would see no TELEGRAM_BOT_TOKEN.
  # runuser keeps the environment. It needs root, hence the check below.
  openclawCtl = pkgs.writeShellScriptBin "openclaw-ctl" ''
    # Usage: sudo openclaw-ctl <openclaw args...>
    set -eu

    if [ "$(id -u)" -ne 0 ]; then
      echo "openclaw-ctl: run as root (sudo openclaw-ctl ...)" >&2
      exit 1
    fi

    if [ -f ${secretsFile} ]; then
      set -a
      . ${secretsFile}
      set +a
    fi

    exec ${pkgs.util-linux}/bin/runuser -u ${cfg.user} -- env \
      HOME=${cfg.stateDir} \
      OPENCLAW_CONFIG_PATH=${cfg.configPath} \
      OPENCLAW_STATE_DIR=${cfg.stateDir} \
      PATH=${cfg.package}/bin:/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin \
      "${cfg.package}/bin/openclaw" "$@"
  '';
in
{
  imports = [ openclaw.nixosModules.openclaw-gateway ];

  # Exposes pkgs.openclaw / pkgs.openclaw-gateway / pkgs.openclawRuntimePlugins.
  nixpkgs.overlays = [ openclaw.overlays.default ];

  services.openclaw-gateway = {
    enable = true;
    package = pkgs.openclaw;

    # Loopback only: Telegram connects *outbound*, so nothing
    # has to be exposed. Reach the dashboard over an SSH tunnel instead:
    #   ssh -L 18789:127.0.0.1:18789 lab@homelab
    port = 18789;

    environmentFiles = [ "-${secretsFile}" ];

    config = {
      gateway = {
        # Required since 2026.10: without it the gateway refuses to start
        # ("existing config is missing gateway.mode", exit status 78).
        mode = "local";
        bind = "loopback";
      };

      models = {
        providers.llamacpp = {
          api = "openai-completions";
          baseUrl = "http://127.0.0.1:2001/v1";
          # llama-server listens without auth on this box.
          apiKey = "none";
          maxTokens = 8192;

          # ids match the models-preset names in services/llama.nix
          models = [
            {
              id = "qwen3.6-35B-A3B";
              name = "Qwen3.6 35B A3B";
              input = [ "text" ];
              reasoning = false;
              contextWindow = 262144;
              cost = {
                input = 0;
                output = 0;
                cacheRead = 0;
                cacheWrite = 0;
              };
            }
            {
              id = "qwen3.8-flash-next-uncensored";
              name = "Qwen3.8 Flash Next Uncensored";
              input = [ "text" ];
              reasoning = false;
              contextWindow = 131072;
              cost = {
                input = 0;
                output = 0;
                cacheRead = 0;
                cacheWrite = 0;
              };
            }
          ];
        };
      };

      agents = {
        defaults = {
          model = {
            primary = "llamacpp/qwen3.8-flash-next-uncensored";
            fallbacks = [
              "llamacpp/qwen3.6-35B-A3B"
            ];
          };
        };
      };

      channels = {
        telegram = {
          enabled = true;
          # token comes from $TELEGRAM_BOT_TOKEN in ${secretsFile}
          dmPolicy = "pairing";
          groups."*" = { requireMention = true; };
          # The gateway owns config; keep it read-only under /etc.
          configWrites = false;
        };
        whatsapp = {
          dmPolicy = "allowlist";
          allowFrom = [ "\${WHATSAPP_ALLOW_FROM}" ];
        };
      };
    };
  };

# The agent talks to llama-server for every turn, so order behind it.
  systemd.services.openclaw-gateway = {
    after = lib.optionals config.services.llama-cpp.enable [ "llama-cpp.service" ];
    wants = lib.optionals config.services.llama-cpp.enable [ "llama-cpp.service" ];

    # Sandbox: the agent can only write to its own state dir and a private /tmp.
    # If eval says an option is "defined multiple times", the upstream module
    # already sets it: change that line to lib.mkForce.
    # MemoryDenyWriteExecute and SystemCallFilter are deliberately left out:
    # Node's JIT breaks under the first and exec tools are fragile under the second.
    serviceConfig = {
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
      PrivateDevices = true;
      ProtectKernelTunables = true;
      ProtectKernelModules = true;
      ProtectKernelLogs = true;
      ProtectControlGroups = true;
      ProtectClock = true;
      ProtectHostname = true;
      RestrictSUIDSGID = true;
      RestrictRealtime = true;
      RestrictNamespaces = true;
      LockPersonality = true;
      SystemCallArchitectures = "native";
      CapabilityBoundingSet = "";
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" "AF_UNIX" ];
      ReadWritePaths = [ cfg.stateDir backupDir ];
    };
  };
  environment.systemPackages = [ openclawCtl ];
  systemd.tmpfiles.rules = [
    "d ${backupDir} 0750 openclaw openclaw -"
  ];
}
