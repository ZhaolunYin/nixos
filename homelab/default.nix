{ ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./users.nix

        ./modules/nixos
        ../share/nixos
    ];

}
