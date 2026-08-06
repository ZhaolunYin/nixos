{ pkgs, inputs, ... }:
let 
    unstable = import inputs.nixpkgs {
        inherit (pkgs.stdenv.hostPlatform) system;
        config = pkgs.config;
    };
in
{
    home.packages = with pkgs; [
        falkon

        unstable.btop
        unstable.mpv
        unstable.ytfzf
        unstable.yt-dlp
    ];
}
