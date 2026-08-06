{ pkgs, inputs, ... }:
let 
    unstable = import inputs.nixpkgs {
        inherit (pkgs.stdenv.hostPlatform) system;
        config = pkgs.config;
    };
in
{
    nixpkgs.config.allowBroken = true;
    environment.systemPackages = with pkgs; [
        dmenu
        git
        neovim
        pass
        (slstatus.override {
            patches = [ ./patches/slstatus.patch ];
        })
        st
        xorg.xinit
    ];
}

