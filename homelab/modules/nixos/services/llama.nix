{ pkgs, ... }:
{
    services.llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp.override {
            cudaSupport = true;
        };

        settings = {
            hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF";
            hf-file = "Qwen3.6-35B-A3B-UD-IQ4_NL_XL.gguf";
            alias = "unsloth/Qwen3.6-35B-A3B";

            ctx-size = 131072;
            n-gpu-layers = 99;

            temp = 0.6;
            top-p = 0.95;
            top-k = 20;
            min-p = 0.0;
            presence-penalty = 1.5;

            reasoning = "off";

            host = "0.0.0.0";
            port = 8080;
            threads = 8;
            parallel = 1;
        };
    };
}
