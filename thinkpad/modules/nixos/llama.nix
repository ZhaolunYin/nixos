{ pkgs, inputs, ... }:
{
    services.llama-cpp = {
        enable = true;
        package = inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.vulkan;

        settings = {
            # device = "Vulkan0";
            threads = 8;
            port = 9931;
            parallel = 1;
            models-max = 1;
            reasoning = "off";
            n-gpu-layers = 0;

            models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
                "Qwen3.6-35B-A3B" = {
                    hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF:UD-IQ4_NL";

                    spec-type = "draft-mtp";
                    spec-draft-n-max = "2";

                    reasoning = "on";
                };
                "LFM2.5-1.2B" = {
                    hf-repo = "LiquidAI/LFM2.5-1.2B-Instruct-GGUF:Q6_K";
                };
                "gemma-4-12B" = {
                    hf-repo = "unsloth/gemma-4-12B-it-qat-GGUF:UD-Q4_K_XL";
                };
            };
        };
    };

    systemd.services.llama-cpp = {
        environment = {
            XDG_CACHE_HOME = "/var/cache/llama-cpp";
            MESA_SHADER_CACHE_DIR = "/var/cache/llama-cpp";
        };
    };

    environment.systemPackages = [
        inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.vulkan
    ];
}
