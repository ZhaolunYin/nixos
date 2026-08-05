{ pkgs, ... }:
{
    nixpkgs.config.doCheck = false;
    nixpkgs.config.doCheckByDefault = false;
    environment.systemPackages = with pkgs; [
        btop
        dmenu
        git
        neovim
        slstatus
        st
        xorg.xinit
    ];
}

