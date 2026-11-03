{ pkgs, ... }:
{
    programs.nix-ld.enable = true;
    environment.systemPackages = with pkgs; [
        cargo
        gcc
        python3
        rustc
    ];
}
