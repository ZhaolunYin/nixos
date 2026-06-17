{ pkgs, ... }:

{
    imports = [
        ./battery.nix
        ./hardware-configuration.nix
        ./users.nix

        ./modules/nixos
    ];

}
