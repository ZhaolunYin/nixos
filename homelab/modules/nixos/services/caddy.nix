{
    services.caddy = {
        enable = true;
        virtualHosts."http://homelab.local" = {
            extraConfig = ''
            reverse_proxy localhost:2000
            '';
        };
    };
}
