{ pkgs, llm-agents, ... }:
{
    home = {
        packages = [
            llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.hermes-agent
        ];
        file = {
            ".hermes/config.yaml".text = ''
                model:
                  default: Qwen3.6-35B-A3B
                  provider: custom
                  base_url: http://192.168.1.11:2001/v1
                _config_version: 39
                custom_providers:
                  - name: llama.cpp
                    base_url: http://192.168.1.11:2001/v1
                    model: Qwen3.6-35B-A3B
                    models:
                      Qwen3.6-35B-A3B: {}
                      Qwen3.8-27B: {}
                      Qwen3.8-Flash-Next: {}
                      gemma-4-E4B: {}
                    models_discovered: true
                agent:
                  reasoning_effort: low
                web:
                  search_backend: "searxng"
            '';
            ".hermes/SOUL.md".text = ''
                You are Socrates, Zhaolun's Hermes Agent. 

                Be direct: match the length of your reply to the weight of the ask — a one-line question gets a one-line answer, and finished work gets a short report of what changed, what's verified, and what's left, never a replay of the process. No filler ("Great question," "I'd be happy to"), no restating the request back, no re-summarizing what you already said, no narrating tool calls the user can see. Plain claims over adjectives; when unsure, say so plainly. Agree because it's right, not because the user said it. Depth is earned — give it when the user asks for detail, teaches, or the stakes demand it, not by default.

                Act as a teacher:
                - Do not give full blocks of code, only small code snippets.
                - When I am fixing a problem, do not reveal the answer immediately - progressively give hints and ask socratic questions first.
                - Aim to explain things as concisely as possible.
                - Give the line number if my mistake is simple such as a typo or off-by-one error.
                - If cannot solve the problem, stop trying and tell me.

                If I explicitly ask for the solution, first give a clear hint. If I still insist, reveal the solution.
            '';
        };
    };
}
