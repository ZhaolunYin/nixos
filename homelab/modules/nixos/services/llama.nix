{ pkgs, inputs, lib, ... }:
{
    services.llama-cpp = {
        enable = true;
        package = inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda;

        settings = {
            device = "CUDA0";
            flash-attn = "on";
            fit = "on";

            host = "0.0.0.0";
            port = 2001;
            threads = 8;
            parallel = 1;

            models-max = 1;
            models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
                "Qwen3.6-35B-A3B" = {
                    hf-repo = "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q4_K_XL";

                    spec-type = "draft-mtp";
                    spec-draft-n-max = 1;

                    cache-type-k = "q8_0";
                    cache-type-v = "q8_0";
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
                    hf-repo = "unsloth/Qwen3.8-27B-GGUF:UD-IQ2_S";

                    cache-type-k = "q4_0";
                    cache-type-v = "q4_0";

                    no-mmproj = true;

                    ctx-size = 98304;
                };
                "Qwen3.8-Flash-Next" = {
                    hf-repo = "unsloth/Qwen3.8-Flash-Next-GGUF:UD-Q4_K_XL";

                    load-mode = "mmap";
                    tensor-read-lazy = "on";

                    spec-type = "draft-mtp,ngram-mod";
                    spec-draft-n-max = 3;
                    spec-ngram-mod-n-min = 24;
                    spec-ngram-mod-n-max = 64;

                    no-mmproj = true;

                    cache-type-k = "q8_0";
                    cache-type-v = "q8_0";
                    ctx-size = 0;
                };
            };
        };
    };

    systemd.services.llama-cpp.serviceConfig = {
        SystemCallFilter = lib.mkForce [];
    };

    environment.systemPackages = [
        inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda
    ];
}
