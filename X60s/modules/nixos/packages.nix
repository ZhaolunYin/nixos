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
            conf = ./patches/slstatus.h;
        })
        (st.override {
            patches = [
                (pkgs.fetchpatch {
                    url = "https://st.suckless.org/patches/scrollback/st-scrollback-20210507-4536f46.diff";
                    hash = "sha256-9qzPHaT7Qd03lJfBeFBebvjmJcw8OzVP2nSqLlLr7Pk=";
                })
            ];
        })
        xorg.xinit
    ];
}

