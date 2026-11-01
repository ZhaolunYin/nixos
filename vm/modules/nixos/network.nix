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

    services.tailscale = {
        enable = true;
        useRoutingFeatures = "client";
    };
}
