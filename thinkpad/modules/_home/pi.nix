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
                    "npm:pi-subagents",
                    "npm:pi-llama-cpp"
                ],
                "llamaServerUrl": "http://127.0.0.1:9931;http://192.168.1.11:2001"
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
