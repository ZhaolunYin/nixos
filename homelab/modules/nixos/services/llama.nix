{ pkgs, inputs, ... }:
{
    services.llama-cpp = {
        enable = true;
        package = inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda;

        settings = {
            # hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF";
            # hf-file = "Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
            # hf-repo = "unsloth/Qwen3.8-27B-GGUF";
            # hf-file = "Qwen3.8-27B-UD-IQ3_XXS.gguf";
            # hf-repo = "ornith-ai/Ornith-1.5-35B-A3B-GGUF";
            # hf-file = "Ornith-1.5-35B-Q4_K_M.gguf";
            hf-repo = "unsloth/Qwen3.8-Flash-Next-GGUF:UD-IQ3_XXS";
            alias = "Qwen3.8-Flash-Next";

            ctx-size = 196608;
            fit = "on";
            device = "CUDA0";

            reasoning = "off";
            tensor-read-lazy = "auto";

            host = "0.0.0.0";
            port = 2001;
            threads = 8;
            parallel = 1;
        };
    };

    environment.systemPackages = [
        inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda
    ];
}
