{
    networking.firewall = {
        allowedTCPPorts = [
            22 # ssh
            80 # caddy
            443 # caddy
        ];
    };
}
