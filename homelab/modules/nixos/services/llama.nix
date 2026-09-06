{ pkgs, llama-cpp, ... }:
let
    qwen-3-8-27b-mtp = pkgs.fetchurl {
        url = "https://huggingface.co/unsloth/Qwen3.8-27B-GGUF/resolve/main/MTP/mtp-Qwen3.8-27B-Q4_0.gguf";
        hash = "sha256-UNnOWm2jgbvPsxBhz3PflKkOb6+O/t3uN5qcuPFQHG4=";
    };
in
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
            models-preset = (pkgs.formats.ini { }).generate "models-preset.ini" {
                "Qwen3.6-35B-A3B" = {
                    hf-repo = "unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q4_K_XL";

                    spec-type = "draft-mtp";
                    spec-draft-n-max = 1;

                    cache-type-k = "q8_0";
                    cache-type-v = "q8_0";
                    ctx-size = 262144;

                };
                "gemma-4-E4B" = {
                    hf-repo = "unsloth/gemma-4-E4B-it-qat-GGUF:UD-Q4_K_XL";

                    spec-type = "draft-mtp";
                    spec-draft-n-max = 4;

                    cache-type-k = "f16";
                    cache-type-v = "f16";
                    ctx-size = 0;
                };
                "Qwen3.8-27B-Q2" = {
                    hf-repo = "unsloth/Qwen3.8-27B-GGUF:UD-Q2_K_XL";

                    cache-type-k = "q4_0";
                    cache-type-v = "q4_0";

                    no-mmproj = true;

                    ctx-size = 65536;
                };
                "Qwen3.8-27B-Q4" = {
                    hf-repo = "unsloth/Qwen3.8-27B-GGUF:UD-Q4_K_M";


                    spec-type = "draft-mtp,ngram-mod";
                    spec-draft-n-max = 2;
                    spec-draft-model = "${qwen-3-8-27b-mtp}";
                    spec-draft-ngl = 0;

                    n-cpu-ffn = 10;

                    cache-type-k = "q4_0";
                    cache-type-v = "q4_0";
                    cache-type-k-draft = "q4_0";
                    cache-type-v-draft = "q4_0";

                    ctx-size = 0;
                };
                "Qwen3.8-Flash-Next" = {
                    hf-repo = "unsloth/Qwen3.8-Flash-Next-GGUF:UD-Q4_K_XL";

                    no-mmproj = true;
                    cpu-moe = true;

                    cache-type-k = "q8_0";
                    cache-type-v = "q8_0";
                    ctx-size = 0;
                };
            };
        };
    };

    environment.systemPackages = [
        llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda
    ];
}
