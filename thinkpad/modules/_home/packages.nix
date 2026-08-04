{ pkgs, ... }:

{
    home.packages = with pkgs; [
        bambu-studio
        ddcutil
        gdb
        google-chrome
        hugo
        hyprshutdown
        kdePackages.kamoso
        mousepad
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        papirus-icon-theme
        pass
        pavucontrol
        pinentry-curses
        proton-vpn
        python3
        unrar
        valgrind
        yazi
        zathura
    ];
}
