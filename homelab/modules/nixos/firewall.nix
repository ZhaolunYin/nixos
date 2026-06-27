{
    networking.firewall = {
        allowedTCPPorts = [
            22 # ssh
            80 # caddy
            2000 # homepage
            2001 # llama.cpp
        ];
    };
}
