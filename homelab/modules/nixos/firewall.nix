{
    networking.firewall = {
        allowedTCPPorts = [
            22 # ssh
            80 # caddy
            2000 # homepage
            2001 # llama.cpp
            2002 # searxng

            5900 # qemu
            5901 # qemu
            5902 # qemu
            5903 # qemu
        ];
    };
}
