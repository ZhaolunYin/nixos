{
    services.caddy = {
        enable = true;
        virtualHosts."http://localhost" = {
            extraConfig = ''
            handle /llama* {
                uri strip_prefix /llama
                reverse_proxy localhost:2000
            }
            handle {
                redir / /llama 302
            }
            '';
        };
    };
}
