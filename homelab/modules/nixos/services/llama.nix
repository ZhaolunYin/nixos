{ pkgs, ... }:
{
    environment.etc."llama-cpp/models.ini".text = ''
        [*]
        ctx-size = 131072
        fit = "on"

        [Qwen3.6-35B-A3B]
        hf = unsloth/Qwen3.6-35B-A3B-GGUF:UD-Q4_K_XL
        ctx-size = 32768

        [Qwen3.8-27B]
        hf = unsloth/Qwen3.8-27B-GGUF:UD-IQ3_XXS
        ctx-size = 32768
    '';
    services.llama-cpp = {
        enable = true;
        package = pkgs.llama-cpp.override {
            cudaSupport = true;
        };


        settings = {
            models-preset = "/etc/llama-cpp/models.ini";
            models-max = 1;
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
