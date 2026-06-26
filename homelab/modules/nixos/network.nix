{
    networking.hostName = "homelab";

    services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
            enable = true;
            addresses = true;
            workstation = true;
        };
        openFirewall = true;
    };

    networking = {
        bridges.br0.interfaces = [ "eno1" ];
        interfaces.br0.ipv4.addresses = [
            {
                address = "192.168.1.11";
                prefixLength = 24;
            }
        ];
        defaultGateway = "192.168.1.1";
        nameservers = [
            "1.1.1.1"
            "8.8.8.8"
        ];
    };
}
