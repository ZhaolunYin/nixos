{ pkgs, ... }:

{
    home.packages = with pkgs; [
        bat
        duf
        dust
        eza
        fd
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
        ripgrep
        trash-cli
        waybar
        yazi
    ];
}
