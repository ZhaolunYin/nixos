{ pkgs, ... }:

{
    home.packages = with pkgs; [
        bat
        blueman
        duf
        dunst
        dust
        eza
        fd
        google-chrome
        grimblast
        hypridle
        hyprlock
        hyprpaper
        hyprshutdown
        mousepad
        networkmanagerapplet
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        papirus-icon-theme
        pass
        pinentry-curses
        procs
        ripgrep
        speedtest
        trash-cli
        waybar
        yazi
    ];
}
