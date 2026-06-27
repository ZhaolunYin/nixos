{
    services.caddy = {
        enable = true;
        virtualHosts."http://localhost" = {
            extraConfig = ''
            handle /llama* {
                reverse_proxy localhost:2000
            }
            '';
        };
    };
}
