{ pkgs, ... }:
{
    services.xserver = {
        enable = true;
        windowManager.dwm = {
            enable = true;
            package = pkgs.dwm.override {
                conf = ./patches/dwm.h;
            };
        };
        displayManager.startx.enable = true;
        videoDrivers = [ "intel" ];
    };
    environment.systemPackages = with pkgs; [
        xorg.xf86videointel
    ];
}
