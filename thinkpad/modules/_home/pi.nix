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
                "defaultModel": "Qwen3.8-Flash-Next",
                "packages": [
                    "npm:pi-llama-cpp",

                    "npm:pi-token-speed",
                    "npm:pi-tool-display",

                    "npm:@juicesharp/rpiv-ask-user-question",
                    "npm:@narumitw/pi-plan-mode",
                    "npm:@narumitw/pi-btw",
                    "npm:@narumitw/pi-progress",

                    "npm:@sting8k/pi-vcc",
                    "npm:pi-context-prune",
                    "npm:pi-searxng",
                    "npm:pi-subagents"
                ],
                "llamaServerUrl": "http://192.168.1.11:2001",
                "llamaSettings": {
                    "serverTimeout": 3600000
                }
                "subagents": {
                    "defaultProvider": "llama-cpp",
                    "defaultModel": "Qwen3.8-27B",
                }
            }
        '';
        ".pi/searxng.json".text = ''
            {
                "searxngUrl": "http://192.168.1.11:2002",
                "timeoutMs": 30000,
                "maxResults": 10
            }
        '';
        ".pi/agent/context-prune/settings.json".text = ''
            {
                "enabled": true,
                "showPruneStatusLine": true,
                "showStartupNotice": true,
                "summarizerModel": "default",
                "summarizerThinking": "default",
                "pruneOn": "agentic-auto",
                "remindUnprunedCount": true,
                "notifySkipped": true,
                "batchingMode": "agent-message"
            }
        '';
    };
}
