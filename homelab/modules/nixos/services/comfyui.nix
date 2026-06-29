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
        config.services.comfyui.host
        "--port"
        (toString config.services.comfyui.port)
        "--user-directory"
        "/var/lib/comfyui"
      ]
      ++ config.services.comfyui.extraOptions
    );

    Restart = "on-failure";

    StateDirectory = "comfyui";

    ProtectSystem = "strict";
    ProtectHome = true;

    ReadWritePaths = [
      config.services.comfyui.modelsDir
      config.services.comfyui.customNodesPath
    ];

    Environment = lib.mapAttrsToList
      (n: v: "${n}=${v}")
      config.services.comfyui.environmentVariables;
  };

  preStart = ''
    mkdir -p ${config.services.comfyui.modelsDir}
    mkdir -p ${config.services.comfyui.customNodesPath}
  '';
};
}
