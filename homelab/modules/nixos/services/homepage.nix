{ lib, ... }:
{
    services.homepage-dashboard = {
        enable = true;
        listenPort = 2000;
        services = [
            {
                AI = [
                    {
                        Llama = {
                            href = "http://homelab.local:2001";
                            description = "Qwen3.6 35B A3B";
                        };
                    }
                    {
                        SearXNG = {
                            href = "http://homelab.local:2002";
                            description = "SearXNG search";
                        };
                    }
                ];
            }
        ];
    };
    systemd.services.homepage-dashboard.environment = {
        HOMEPAGE_ALLOWED_HOSTS = lib.mkForce "*";
    };
}
