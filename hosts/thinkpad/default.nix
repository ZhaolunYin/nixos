{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./battery.nix
        ./users.nix
    ];

}
