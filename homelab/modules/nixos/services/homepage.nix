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
                            description = "Qwen3.6 35B A3B";
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
            {
                Development = [
                    {
                        Forgejo = {
                            href = "http://192.168.1.11:2003";
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
