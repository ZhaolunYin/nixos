{ pkgs, ... }:
{
    home.packages = with pkgs; [
        falkon
    ];
}
