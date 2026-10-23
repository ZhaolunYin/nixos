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
                            href = "http://192.168.1.11:2001";
                            description = "Local AI models";
                        };
                    }
                    {
                        SearXNG = {
                            href = "http://192.168.1.11:2002";
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
