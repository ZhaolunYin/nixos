{
    networking.hostName = "projector";

    services.avahi = {
        enable = true;
        nssmdns4 = true;
    };

    networking = {
        wireless.iwd = {
            enable = true;
        };
        networkmanager = {
            enable = true;
            wifi.backend = "iwd";
        };
        useDHCP = false;
        interfaces.wlan0 = {
            ipv4.addresses = [{
                address = "192.168.1.136";
                prefixLength = 24;
            }];
        };
        defaultGateway = "192.168.1.1";
        nameservers = [
            "1.1.1.1"
            "8.8.8.8"
        ];
    };
}
