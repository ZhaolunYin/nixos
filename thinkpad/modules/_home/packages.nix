{ pkgs, ... }:
{
    home.packages = with pkgs; [
        bambu-studio
        ddcutil
        gdb
        hugo
        kdePackages.kamoso
        llama-cpp-vulkan
        mousepad
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        papirus-icon-theme
        pass
        pavucontrol
        pinentry-curses
        proton-vpn
        python3
        otpclient
        tor
        torsocks
        tor-browser
        unrar
        valgrind
        yazi
        zathura
    ];
}
