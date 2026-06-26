{
    services.caddy = {
        enable = true;
        services.caddy.virtualHosts."192.168.1.11".extraConfig = ''
            handle /llama/* {
                uri strip_prefix /llama
                reverse_proxy 127.0.0.1:8080
            }
        '';
    };
}
