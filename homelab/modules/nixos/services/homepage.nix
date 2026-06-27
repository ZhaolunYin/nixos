{
    services.homepage-dashboard = {
        enable = true;
        listenPort = 80;
        services = [
            {
                "AI" = [
                    {
                        "Llama" = {
                            href = "http://homelab.local:2000";
                            description = "Qwen3 35B";
                        };
                    }
                ];
            }
        ];
    };
}
