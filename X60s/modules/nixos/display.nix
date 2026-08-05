{ pkgs, ... }:
{
    services.xserver = {
        enable = true;
        windowManager.dwm.enable = true;
        displayManager.startx.enable = true;
        videoDrivers = [ "intel" ];
    };
    environment.systemPackages = with pkgs; [
        xorg.xf86videointel
    ];
}
