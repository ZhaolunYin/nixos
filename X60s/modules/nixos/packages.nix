{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        dmenu
        git
        neovim
        slstatus
        st
    ];
}

