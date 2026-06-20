{
    # Enable Tailscale with subnet routing
    services.tailscale = {
        enable = true;
        useRoutingFeatures = "server";
    };
    networking.firewall.allowedUDPPorts = [ 41641 ];
    networking.firewall.allowedTCPPorts = [ 443 ];
}
