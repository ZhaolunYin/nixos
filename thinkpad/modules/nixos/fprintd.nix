{ pkgs, ... }:
{
    services.fprintd.enable = true;
    systemd.services.restart-fprintd = {
        description = "Restart fprintd after suspend";
        after = [ "sleep.target" ];
        wantedBy = [ "sleep.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = "${pkgs.systemd}/bin/systemctl restart fprintd.service";
        };
    };
}
