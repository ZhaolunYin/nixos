{
    networking = {
        wireless.iwd = {
            enable = true;
        };
        networkmanager = {
            enable = true;
            wifi.backend = "iwd";
            wifi.powersave = false;
            unmanaged = [ "interface-name:usb0" ];
        };

        interfaces.usb0.ipv4.addresses = [{
            address = "10.55.0.1";
            prefixLength = 24;
        }];

        nat = {
            enable = true;
            externalInterface = "wlan0";
            internalInterfaces = [ "usb0" ];
        };

        firewall.trustedInterfaces = [ "usb0" ];
    };

    services.dnsmasq = {
        enable = true;
        settings = {
            port = 0;
            interface = "usb0";
            bind-interfaces = true;
            dhcp-range = [ "10.55.0.10,10.55.0.50,24h" ];
            dhcp-option = [
                "option:router,10.55.0.1"
                    "option:dns-server,10.55.0.1"
            ];
        };
    };

    services.adguardhome = {
        enable = true;
    };
}
