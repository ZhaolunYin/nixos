{ config, lib, pkgs, ... }:
let
    cfg = config.services.openclaw;
    stateDir = cfg.dataDir;
    configFile = (pkgs.formats.json { }).generate "openclaw.json" openclawConfig;

    llamaModel = "qwen3.8-27B";

    openclawConfig = {
        gateway = {
            mode = "local";
            port = cfg.gatewayPort;
            bind = "loopback";
        };

        models = {
            mode = "merge";
            providers.llama-server = {
                baseUrl = "http://127.0.0.1:2001/v1";
                apiKey = "none";
                api = "openai-completions";
                models = [
                    {
                        id = llamaModel;
                        name = llamaModel;
                        reasoning = false;
                        input = [ "text" ];
                        cost = { input = 0; output = 0; cacheRead = 0; cacheWrite = 0; };
                        contextWindow = 131072;
                        maxTokens = 8192;
                    }
                ];
            };
        };

        agents.defaults.model.primary = "llama-server/${llamaModel}";

        channels = {
            # Unknown senders get a pairing code; you approve them with
            #   openclaw-ctl pairing approve <whatsapp|telegram> <CODE>
            whatsapp.dmPolicy = "pairing";
            telegram = {
                enabled = true;
                tokenFile = "${stateDir}/secrets/telegram-token";
                dmPolicy = "pairing";
            };
        };
    };

    openclawEnv = {
        HOME = stateDir;
        OPENCLAW_STATE_DIR = "${stateDir}/state";
        OPENCLAW_CONFIG_PATH = "${configFile}";
        OPENCLAW_NIX_MODE = "1";
    };

    start = pkgs.writeShellScript "openclaw-gateway-start" ''
        export OPENCLAW_GATEWAY_TOKEN="$(cat ${cfg.authTokenFile})"
        exec ${cfg.package}/bin/openclaw gateway run \
            --port ${toString cfg.gatewayPort} --bind loopback --auth token
    '';

    # Run the CLI as the service user with the same state/config as the gateway,
    # e.g. `openclaw-ctl channels login --channel whatsapp`.
    ctl = pkgs.writeShellScriptBin "openclaw-ctl" ''
        exec sudo -u openclaw env \
            ${lib.concatStringsSep " " (lib.mapAttrsToList (k: v: "${k}=${v}") openclawEnv)} \
            ${cfg.package}/bin/openclaw "$@"
    '';
in
{
    services.openclaw = {
        enable = true;
        gatewayPort = 18789;
        openFirewall = false; # gateway is loopback-only; WhatsApp/Telegram are outbound
        # domain left empty: no Caddy vhost. Your existing caddy.nix is untouched.
    };
    systemd.services.openclaw-gateway = {
        environment = openclawEnv;
        serviceConfig = {
            # The upstream module writes its own config in a format OpenClaw
            # doesn't read, so replace the start command.
            ExecStart = lib.mkForce "${start}";
            # Node's os.networkInterfaces() needs netlink.
            RestrictAddressFamilies = lib.mkForce [ "AF_INET" "AF_INET6" "AF_UNIX" "AF_NETLINK" ];
        };
        # llama-server must be up for the model to answer, but don't hard-fail without it.
        after = [ "llama-cpp.service" ];
    };

    systemd.tmpfiles.rules = [
        "d ${stateDir}/state   0700 openclaw openclaw -"
        "d ${stateDir}/secrets 0700 openclaw openclaw -"
    ];

    environment.systemPackages = [ ctl ];
}
