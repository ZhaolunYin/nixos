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
        feh
        unstable.gcc
        git
        jq
        neovim
        pass
        (slstatus.override {
            conf = ./patches/slstatus.h;
        })
        (st.override {
            patches = [
                (pkgs.fetchpatch {
                    url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff";
                    hash = "sha256-ZypvRONAHS//wnZjivmqpWIqZlKTqAQ0Q8DhQpZVaqU=";
                })
            ];
        })
        xorg.xinit
    ];
}

