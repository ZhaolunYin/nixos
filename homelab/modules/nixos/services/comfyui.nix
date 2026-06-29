{ config, lib, pkgs, ... }:
{
systemd.services.comfyui = {
  description = "ComfyUI";
  wantedBy = [ "multi-user.target" ];
  after = [ "network-online.target" ];

  serviceConfig = {
    Type = "simple";

    User = "comfyui";
    Group = "comfyui";

    WorkingDirectory = "/var/lib/comfyui";

    ExecStart = lib.concatStringsSep " " (
      [
        "${lib.getExe pkgs.comfyui}"
        "--listen"
        cfg.host
        "--port"
        (toString cfg.port)
        "--user-directory"
        "/var/lib/comfyui"
      ]
      ++ cfg.extraOptions
    );

    Restart = "on-failure";

    StateDirectory = "comfyui";

    ProtectSystem = "strict";
    ProtectHome = true;

    ReadWritePaths = [
      cfg.modelsDir
      cfg.customNodesPath
    ];

    Environment = lib.mapAttrsToList
      (n: v: "${n}=${v}")
      cfg.environmentVariables;
  };

  preStart = ''
    mkdir -p ${cfg.modelsDir}
    mkdir -p ${cfg.customNodesPath}
  '';
};
}
