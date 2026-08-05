{ pkgs, ... }:
{
    home.packages = with pkgs; [
        kdePackages.falkon
    ];
}
