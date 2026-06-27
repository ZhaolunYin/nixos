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
            {
                Development = [
                    {
                        Forgejo = {
                            icon = "mdi:git";
                            href = "http://homelab.local:2003";
                            description = "Forgejo self-hosted Git";
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
