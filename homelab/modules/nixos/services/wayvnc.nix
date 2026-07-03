{ pkgs, ... }:
{
    services = {
        desktopManager.plasma6.enable = false;
        displayManager.sddm.enable = false;
    };

    programs = {
        sway = {
            enable = true;
            wrapperFeatures.base = true;
            wrapperFeatures.gtk = true;
            xwayland.enable = true;
        };

        wayvnc = {
            enable = true;
        };
    };

    environment.etc."sway/config.d/wayvnc.conf".text = ''
        exec ${pkgs.wayvnc}/bin/wayvnc &
    '';
}
