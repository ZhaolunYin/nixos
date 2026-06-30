{
    networking.firewall = {
        allowedTCPPorts = [
            22 # ssh
            80 # caddy
            2000 # homepage
            2001 # llama.cpp
            2002 # searxng
            2003 # forgejo
        ];
/*
Services with ports not included: 
- Sunshine
- Steam
*/
    };
}
