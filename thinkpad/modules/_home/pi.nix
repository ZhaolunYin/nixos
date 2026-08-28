{ pkgs, ... }:
{
    home.packages = with pkgs; [
        pi-coding-agent
        nodejs
    ];

    home.file = {
        ".pi/agent/settings.json".text = ''
            {
                "defaultProvider": "llama-cpp",
                "packages": [
                    "npm:pi-mcp-adapter",
                    "npm:pi-agenticoding",
                    "npm:pi-subagents"
                ]
            }
        '';
        ".pi/agent/models.json".text = ''
            {
                "providers": {
                    "llama-cpp": {
                        "baseUrl": "http://192.168.1.11:2001/v1",
                        "api": "openai-completions",
                        "apiKey": "none",
                        "models": [
                            {
                                "id": "Qwen3.8-Flash-Next",
                                "contextWindow": 196608,
                            }
                        ]
                    }
                }
            }
        '';
        ".config/mcp/mcp.json".text = ''
            {
                "mcpServers": {
                    "searxng": {
                        "command": "npx",
                            "args": [
                                "-y",
                            "mcp-searxng"
                            ],
                            "env": {
                                "SEARXNG_URL": "http://192.168.1.11:2002"
                            }
                    }
                }
            }
        '';
    };
}
