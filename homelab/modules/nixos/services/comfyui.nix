{ pkgs, config, lib, ... }:
let
  cfg = config.services.comfyui;
in
{
  options.services.comfyui = {
    enable = lib.mkEnableOption "ComfyUI service";

    port = lib.mkOption {
      type = lib.types.port;
      default = 8188;
      description = "Port to run ComfyUI on.";
    };

    host = lib.mkOption {
      type = lib.types.str;
      default = "0.0.0.0";
      description = "Host address to bind ComfyUI to.";
    };

    extraOptions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Extra command-line options for ComfyUI.";
    };

    modelsDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/comfyui/models";
      description = "Directory to store ComfyUI model checkpoints.";
    };

    customNodesPath = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/comfyui/custom_nodes";
      description = "Directory for ComfyUI custom nodes.";
    };

    environmentVariables = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Additional environment variables for the ComfyUI service.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.comfyui = {
      description = "ComfyUI - The most powerful and modular stable diffusion GUI";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];

      serviceConfig = {
        Type = "simple";
        User = "comfyui";
        Group = "comfyui";
        Restart = "on-failure";
        RestartSec = "5s";

        WorkingDirectory = "${pkgs.comfyui}/ComfyUI";
        ExecStart = ''
          ${pkgs.comfyui}/ComfyUI/venv/bin/python \
            main.py \
              --port ${toString cfg.port} \
              --listen ${cfg.host} \
              --force-fp16 \
              ${lib.concatStringsSep "\n  " cfg.extraOptions}
        '';

        Environment = lib.mapAttrsToList (name: value: "${name}=${value}") cfg.environmentVariables;

        # Security hardening
        ProtectSystem = "strict";
        ProtectHome = "yes";
        ReadWritePaths = cfg.modelsDir + " " cfg.customNodesPath;
        PrivateTmp = "yes";
      };

      preStart = ''
        mkdir -p ${cfg.modelsDir} ${cfg.customNodesPath}
      '';
    };

    # Create dedicated user for the service
    users.users.comfyui = {
      isSystemUser = true;
      group = "comfyui";
      home = "/var/lib/comfyui";
      createHome = true;
    };

    users.groups.comfyui = {};
  };
}
