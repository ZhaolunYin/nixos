{ pkgs, llm-agents, ... }:
{
    home = {
        packages = [
            llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.dsh
            pkgs.pnpm
        ];
        sessionVariables.LLAMA_CPP_API_KEY = "none";
        file = {
            ".dsh/settings.yaml".text = ''
                ui-onboarding:
                  welcomeNoticeVersion: 2026-08-13.1
                llm-pi-ai:
                  providers:
                    llama-cpp:
                      displayName: llama.cpp
                      apiKeyEnv: LLAMA_CPP_API_KEY
                      api: openai-completions
                      baseURL: http://192.168.1.11:2001/v1
                      defaultMaxTokens: 2097152
                      models:
                        - id: Qwen3.6-35B-A3B
                        - id: Qwen3.8-27B
                        - id: Qwen3.8-Flash-Next
                        - id: gemma-4-E4B
                agent-default-model:
                  provider: llama-cpp
                  model: Qwen3.6-35B-A3B
            '';
            ".dsh/profiles/web/package.json".text = ''
                {
                  "name": "dsh-profile-web",
                  "private": true,
                  "dependencies": {
                    "@deepseek-ai/dsh-mcp-client": "0.1.1-rc.2"
                  },
                  "dsh": {
                    "profile": {
                      "bundles": [
                        "@deepseek-ai/dsh-base",
                        "@deepseek-ai/dsh-web-app"
                      ]
                    }
                  }
                }
            '';
            ".dsh/profiles/web/cordis.patch.yml".text = ''
                # Your patch layer for this dsh profile, applied after every bundle layer:
                # a top-level YAML array of loader patch entries (id-targeted config
                # overrides, disables, and insert lists; `!!js` expressions allowed).
                - id: agent-default-model
                  config:
                    provider: llama-cpp
                    model: Qwen3.8-27B

                - id: llm-deepseek
                  disabled: true

                - id: web-search-deepseek
                  disabled: true

                - insert:
                    - id: mcp-searxng
                      name: '@deepseek-ai/dsh-mcp-client'
                      config:
                        serverName: searxng
                        transport: stdio
                        command: npx
                        args:
                          - -y
                          - mcp-searxng
                        env:
                          SEARXNG_URL: http://192.168.1.11:2002
            '';
        };
    };
}
