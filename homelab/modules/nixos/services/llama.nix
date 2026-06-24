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

            temp = 0.7;
            top-p = 0.8;
            top-k = 20;
            min-p = 0.0;

            presence-penalty = 1.5;
            reasoning = "off";
        };
    };
}
