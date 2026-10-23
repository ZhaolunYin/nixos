{ pkgs, llama-cpp, ... }:
{
    services.llama-cpp = {
        enable = true;
        package = llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda;

        settings = {
            device = "CUDA0";
            flash-attn = "on";
            fit = "on";

            host = "0.0.0.0";
            port = 2001;
            threads = 8;
            parallel = 1;

            jinja = true;

            models-max = 1;
            sleep-idle-seconds = 600;
            models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
                "DEFAULT Qwen3.6-35B-A3B" = {
                    hf-repo = "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q4_K_XL";

                    spec-type = "draft-mtp";
                    spec-draft-n-max = 1;

                    moe-cache-mib = 1792;
                    cache-type-k = "q8_0";
                    cache-type-v = "q8_0";
                    ctx-size = 262144;

                };
                "Nvidia-Nemotron-3.5-Bolt-74B-A9B" = {
                    hf-repo = "unsloth/NVIDIA-Nemotron-3.5-Bolt-74B-A9B-GGUF:UD-IQ2_XXS";

                    moe-cache-mib = 2048;
                    cache-type-k = "q4_0";
                    cache-type-v = "q4_0";
                    ctx-size = 131072;
                };
                "gemma-4-E4B" = {
                    hf-repo = "unsloth/gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL";

                    spec-type = "draft-mtp";
                    spec-draft-n-max = 4;

                    cache-type-k = "f16";
                    cache-type-v = "f16";
                    ctx-size = 0;
                };
                "Qwen3.8-27B" = {
                    hf-repo = "unsloth/Qwen3.8-27B-GGUF:UD-Q2_K_XL";

                    cache-type-k = "q4_0";
                    cache-type-v = "q4_0";

                    no-mmproj = true;

                    ctx-size = 65536;
                };
                "Qwen3.8-Flash-Next" = {
                    hf-repo = "unsloth/Qwen3.8-Flash-Next-GGUF:UD-IQ3_XXS";

                    no-mmproj = true;

                    moe-cache-mib = 2688;
                    cache-type-k = "q8_0";
                    cache-type-v = "q8_0";
                    ctx-size = 65536;
                };
            };
        };
    };

    environment.systemPackages = [
        llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda
        pkgs.python3Packages.huggingface-hub
    ];
}
