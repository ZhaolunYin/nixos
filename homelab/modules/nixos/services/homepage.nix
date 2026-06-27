{
    services.homepage-dashboard = {
        enable = true;
        listenPort = 2000;
        services = [
            {
                "AI" = [
                    {
                        "Llama" = {
                            href = "http://homelab.local:2001";
                            description = "Qwen3 35B";
                        };
                    }
                ];
            }
        ];
    };
}
