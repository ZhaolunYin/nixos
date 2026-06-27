{ pkgs, ... }:
{
    services.llama-cpp = {
        enable = true;

        settings = {
            hf-repo = "unsloth/Qwen3.6-35B-A3B-GGUF";
            hf-file = "Qwen3.6-35B-A3B-UD-IQ4_NL_XL.gguf";
            alias = "unsloth/Qwen3.6-35B-A3B";

            ctx-size = 131072;
            fit = "on";
            device = "CUDA0";

            temp = 0.6;
            top-p = 0.95;
            top-k = 20;
            min-p = 0.0;
            presence-penalty = 1.5;

            reasoning = "off";

            host = "0.0.0.0";
            port = 2000;
            threads = 8;
            parallel = 1;
        };
    };

    environment.systemPackages = with pkgs; [
        llama-cpp
    ];
}
