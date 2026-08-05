{ pkgs, ... }:
{
    nixpkgs.config.doCheck = false;
    nixpkgs.config.doCheckByDefault = false;
    environment.systemPackages = with pkgs; [
        dmenu
        git
        neovim
        slstatus
        st
        xorg.xinit
    ];
}

