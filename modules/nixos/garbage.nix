# /etc/nixos/configuration.nix

{
    nix.gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 2d";
    };
}
