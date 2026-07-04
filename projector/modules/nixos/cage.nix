{ pkgs, ... }:
{
    programs.firefox.enable = true;

    services.cage = {
        enable = true;
        user = "projector";
        program = "${pkgs.firefox}/bin/firefox --kiosk";
    };
}
