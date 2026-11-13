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
            ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/lyrebird";
            Bridge = [
                "obfs4 93.224.89.203:38697 AABE1DC146DF55E9B2B1D32FD0427C3A800BD9AD cert=TPbW/AGJO6DsofB6c8JwmnMyHIjaxlFb1a2trky23ood7vs/S0CSqC2lOeWNaJr5Tc4bdg iat-mode=0"
                "obfs4 79.134.121.43:8443 7F016A33C0789FD21D51F2AFAAFC4FEDF6865069 cert=7nieVFV4BFhW51Y37C/M4FLuvmU43RSXIKjhhteDbOJctKSpckMbWoUOz41NovIrZtdOfQ iat-mode=0"
                "obfs4 31.76.50.102:8443 E29BFDBF195F7C994139ED726DD0D5FBA0BE8853 cert=0aZMBsmQ9maXZ+0fvBBzxY/94qZobw0dS0q2DqPYnlsa2tUHbJFInV1n5oE2QWP+qeyKcw iat-mode=0"
                "obfs4 172.93.1.28:9443 1F7DA21894BEA4CC774FF4269AFB668CE1D09305 cert=kETRz1hkwiZhS5q9I8a71K3rygLMU6aYKXBuEyzVq3hi2KS++LftBpJ8D9aRppeUq6KZXw iat-mode=0"
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

