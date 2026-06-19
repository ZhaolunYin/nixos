{
    # Enable Tailscale with subnet routing
    services.tailscale = {
        enable = true;
        useRoutingFeatures = "server";
        extraSetFlags = [
            "--advertise-routes=192.168.1.0/24"
            "--advertise-exit-node"
        ];
    };
    networking.firewall.allowedUDPPorts = [ 41641 ];
    networking.firewall.allowedTCPPorts = [ 443 ];
}
