{
    networking.hostName = "homelab";

    services.avahi = {
        enable = true;
        nssmdns4 = true;
    };

    networking = {
        networkmanager.enable = true;
        nameservers = [
            "1.1.1.1"
            "8.8.8.8"
        ];
    };
}
