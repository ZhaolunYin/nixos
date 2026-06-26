{
    services.caddy = {
        enable = true;
        virtualHosts.":80".extraConfig = ''
            handle /llama/* {
                uri strip_prefix /llama
                reverse_proxy 127.0.0.1:8080
            }
        '';
    };
}
