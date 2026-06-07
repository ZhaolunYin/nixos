{ pkgs, ... }:

{
    home.packages = with pkgs; [
        bat
        ddcutil
        duf
        dust
        eza
        fd
        git-lfs
        git-xet
        google-chrome
        grimblast
        hyprshutdown
        kdePackages.kamoso
        mousepad
        networkmanagerapplet
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        papirus-icon-theme
        pass
        pavucontrol
        pinentry-curses
        procs
        python3
        ripgrep
        trash-cli
        waybar
        yazi
    ];
}
