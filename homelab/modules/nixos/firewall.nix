{
    networking.firewall = {
        allowedTCPPorts = [
            22 # ssh
            80 # homepage
            2000 # llama.cpp
        ];
    };
}
