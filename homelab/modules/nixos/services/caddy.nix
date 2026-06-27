{
    services.caddy = {
        enable = true;
        virtualHosts."http://homelab.local" = {
            extraConfig = ''
            reverse_proxy localhost:2000
            '';
        };
        virtualHosts."http://192.168.1.11" = {
            extraConfig = ''
            reverse_proxy localhost:2000
            '';
        };
    };
}
