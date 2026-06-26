{
    networking.firewall = {
        allowedTCPPorts = [
            22 # ssh
            80 # llama.cpp
        ];
    };
}
