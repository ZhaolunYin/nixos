{ pkgs, inputs, ... }:
{
    services.llama-cpp = {
        enable = true;
        package = inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda;

        settings = {
            # hf-repo = "unsloth/Qwen3.8-27B-GGUF";
            # hf-file = "Qwen3.8-27B-UD-IQ3_XXS.gguf";
            # hf-repo = "ornith-ai/Ornith-1.5-35B-A3B-GGUF";
            # hf-file = "Ornith-1.5-35B-Q4_K_M.gguf";

            device = "CUDA0";
            ctx-size = 0;

            flash-attn = "on";

            host = "0.0.0.0";
            port = 2001;
            threads = 8;
            parallel = 1;

            models-max = 1;
            models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
                "Qwen3.6-35B-A3B" = {
                    hf-repo = "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q4_K_XL";
                    spec-type = "draft-mtp";
                };
                "Qwen3.8-Flash-Next" = {
                    hf-repo = "unsloth/Qwen3.8-Flash-Next-GGUF:UD-IQ1_M";
                    load-mode = "mmap";
                    tensor-read-lazy = "on";
                };
            };
        };
    };

    environment.systemPackages = [
        inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda
    ];
}
