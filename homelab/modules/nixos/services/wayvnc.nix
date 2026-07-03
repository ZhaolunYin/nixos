{ pkgs, ... }:
{
    programs.wayvnc = {
        enable = true;
    };

    systemd.services.wayvnc = {
        description = "wayvnc VNC server for headless Wayland";
        after = [ "multi-user.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.wayvnc}/bin/wayvnc --detached 0.0.0.0";
        };
    };
}
