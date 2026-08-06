{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        dmenu
        git
        neovim
        pass
        slstatus
        st
        xorg.xinit
    ];
}

