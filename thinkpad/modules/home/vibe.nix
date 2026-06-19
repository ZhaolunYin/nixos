{ pkgs, ... }:

let qwenModel = pkgs.fetchurl {
	url = "https://huggingface.co/unsloth/Qwen3.6-35B-A3B-GGUF/resolve/main/Qwen3.6-35B-A3B-UD-IQ4_NL.gguf";
	hash = "sha256-DRfiVdwlehHzmO1LyNYkEtjOnKJLP84pR9li5L/tV1g=";
};
in
{
	home.packages = with pkgs; [
/*        (llama-cpp.override {
			vulkanSupport = true;
		})*/
		pi-coding-agent
	];

	/*systemd.user.services.llama-server = {
		Unit = {
			Description = "llama.cpp server";
			After = [ "network.target" ];
		};

		Service = {
			ExecStart = ''
				/etc/profiles/per-user/zhaolun/bin/llama-server \
				-m ${qwenModel} \
				--device Vulkan0 \
				-ngl 10 \
				--reasoning off \
				-c 131072
				'';

			Restart = "on-failure";
			RestartSec = 5;
		};

		Install = {
			WantedBy = [ "default.target" ];
		};
	};*/

	home.file = {
		".pi/agent/settings.json".text = ''
			{
				"defaultProvider": "llama-cpp",
				"defaultModel": "Qwen3.6-35B-A3B-UD-IQ4_NL.gguf",
				"packages": [
					"npm:pi-mcp-adapter"
				]
			}
		'';
		".pi/agent/models.json".text = ''
			{
				"providers": {
					"llama-cpp": {
						"baseUrl": "http://192.168.1.109/v1",
						"api": "openai-completions",
						"apiKey": "none",
						"models": [
							{
								"id": "Qwen3.6-35B-A3B-UD-IQ4_NL.gguf"
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
							"SEARXNG_URL": "http://127.0.0.1:8888"
						}
					}
				}
			}
		'';
	};
}
