{
    networking.firewall = {
        allowedTCPPorts = [
            22 # ssh
            1000 # llama.cpp
        ];
    };
}
