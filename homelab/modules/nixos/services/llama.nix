{ pkgs, ... }:
{
    services.llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp.override {
            cudaSupport = true;
        };


        settings = {
            # hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF";
            # hf-file = "Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf";
            hf-repo = "unsloth/Qwen3.8-27B-GGUF";
            hf-file = "Qwen3.8-27B-UD-IQ3_XXS.gguf";
            alias = "Qwen3.8";

            ctx-size = 131072;
            fit = "on";
            device = "CUDA0";

            reasoning = "on";

            host = "0.0.0.0";
            port = 2001;
            threads = 8;
            parallel = 1;
        };
    };

    environment.systemPackages = with pkgs; [
        (llama-cpp.override { cudaSupport = true; })
    ];
}
