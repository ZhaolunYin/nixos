{ pkgs, ... }:
let
  torSocksPort = 9050;
  torHttpPort = 9080; # Tor's HTTP CONNECT proxy, the best-supported path for Go's proxy handling
  proxyUrl = "http://127.0.0.1:${toString torHttpPort}";
in
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

    services.tor = {
        enable = true;
        client.enable = true; # local SOCKS listener, client-only (no relay)
        settings = {
            HTTPTunnelPort = {
                addr = "127.0.0.1";
                port = torHttpPort;
            };

            UseBridges = true;
            ClientTransportPlugin = "snowflake exec ${pkgs.snowflake}/bin/client";
            Bridge = [
                "snowflake 192.0.2.3:80 2B280B23E1107BB62ABFC40DDCC8824814F80A72 fingerprint=2B280B23E1107BB62ABFC40DDCC8824814F80A72 url=https://1098762253.rsc.cdn77.org/ fronts=www.cdn77.com,www.phpmyadmin.net ice=stun:stun.antisip.com:3478,stun:stun.epygi.com:3478,stun:stun.uls.co.za:3478,stun:stun.voipgate.com:3478 utls-imitate=hellorandomizedalpn"
            ];
        };
    };

    services.tailscale = {
        enable = true;
        useRoutingFeatures = "client";
    };

    systemd.services.tailscaled = {
        after = [ "tor.service" ];
        wants = [ "tor.service" ];

        environment = {
            HTTPS_PROXY = proxyUrl;
            HTTP_PROXY = proxyUrl;
            NO_PROXY = "localhost,127.0.0.1,::1";
        };
    };
}

