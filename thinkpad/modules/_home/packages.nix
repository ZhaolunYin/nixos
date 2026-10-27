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
        supertuxkart
        tor
        torsocks
        tor-browser
        # Pins the primary selection so it survives app restarts
        wl-clip-persist
        # Colour picker (bind: CTRL+SHIFT+P)
        hyprpicker
        # GUI for the same settings.ini / fontconfig that gtk.nix writes
        nwg-look
        unrar
        unsloth-desktop
        valgrind
        yazi
        zathura
    ];
}
