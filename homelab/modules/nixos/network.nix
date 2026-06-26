{
    networking.hostName = "homelab";

    services.avahi = {
        enable = true;
        nssmdns4 = true;
    };

    networking = {
        networkmanager.enable = true;
        interfaces.eno1 = {
            ipv4.addresses = [{
                address = "192.168.1.10";
                prefixLength = 24;
            }];
        };
        bridges.br0.interfaces = [ "eth0" "eth1" ];
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
