{ pkgs, ... }:
{
    services.xserver = {
        enable = true;
        windowManager.dwm.enable = true;
        displayManager.lightdm.enable = true;
    };
    environment.systemPackages = with pkgs; [
        st
        dmenu
        slstatus
    ];
}
