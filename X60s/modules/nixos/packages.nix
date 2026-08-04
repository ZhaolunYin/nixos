{ pkgs, ... }:
{
    nixpkgs.config.doCheck = false;
    environment.systemPackages = with pkgs; [
        dmenu
        git
        neovim
        slstatus
        st
        xorg.xinit
    ];
}

