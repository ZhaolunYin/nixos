{ pkgs, ... }:

{
    home.packages = with pkgs; [
        ddcutil
        google-chrome
        hyprshutdown
        kdePackages.kamoso
        moonlight-qt
        mousepad
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        papirus-icon-theme
        pass
        pavucontrol
        pinentry-curses
        proton-vpn
        python3
        yazi
    ];
}
