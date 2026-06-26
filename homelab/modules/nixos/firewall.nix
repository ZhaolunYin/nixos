{
    networking.firewall = {
        allowedTCPPorts = [
            22 # ssh
            8080 # llama.cpp
        ];
    };
}
