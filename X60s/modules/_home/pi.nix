{ pkgs, inputs, ... }:
let 
    unstable = import inputs.nixpkgs {
        inherit (pkgs.stdenv.hostPlatform) system;
        config = pkgs.config;
    };
in
{
    home.packages = [ unstable.pi-coding-agent ];
    home.file = {
        ".pi/agent/settings.json".text = ''
            { "defaultProvider": "llama-cpp",
                "defaultModel": "unsloth/Qwen3.6-35B-A3B",
                "packages": [
                    "npm:pi-mcp-adapter"
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
                                "id": "unsloth/Qwen3.6-35B-A3B"
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
