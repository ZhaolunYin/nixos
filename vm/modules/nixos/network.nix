{
    networking.hostName = "nixos-vm";

    services.avahi = {
        enable = true;
        nssmdns4 = true;
    };

    networking = {
        networkmanager = {
            enable = true;
        };
    };
}
