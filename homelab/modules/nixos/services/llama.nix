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

                    ctx-size = 98304;
                };
                "Qwen3.8-Flash-Next" = {
                    hf-repo = "unsloth/Qwen3.8-Flash-Next-GGUF:UD-IQ1_M";

                    load-mode = "mmap";
                    tensor-read-lazy = "on";

                    cache-type-k = "q8_0";
                    cache-type-v = "q8_0";
                    ctx-size = 0;
                };
            };
        };
    };

    systemd.services.llama-cpp = {
        environment = {
            LLAMA_CACHE = "/var/cache/llama-cpp";
            HF_HOME = "/var/cache/llama-cpp";
        };

        serviceConfig = {
            User = lib.mkForce "root";
            DynamicUser = lib.mkForce false;

            PrivateUsers = lib.mkForce false;
            PrivateMounts = lib.mkForce false;
            PrivateTmp = lib.mkForce false;

            ProtectHome = lib.mkForce false;
            ProtectSystem = lib.mkForce false;

            NoNewPrivileges = lib.mkForce false;
            MemoryDenyWriteExecute = lib.mkForce false;

            RestrictNamespaces = lib.mkForce false;
            RestrictSUIDSGID = lib.mkForce false;
            RestrictRealtime = lib.mkForce false;

            SystemCallFilter = lib.mkForce [];
            SystemCallArchitectures = lib.mkForce [];
            RestrictAddressFamilies = lib.mkForce [];

            LockPersonality = lib.mkForce false;
            ProtectClock = lib.mkForce false;
            ProtectControlGroups = lib.mkForce false;
            ProtectHostname = lib.mkForce false;
            ProtectKernelLogs = lib.mkForce false;
            ProtectKernelModules = lib.mkForce false;
            ProtectKernelTunables = lib.mkForce false;
            ProtectProc = lib.mkForce "default";
            ProcSubset = lib.mkForce "all";

            LimitMEMLOCK = lib.mkForce "infinity";
        };
    };

    environment.systemPackages = [
        inputs.llama-cpp.packages.${pkgs.stdenv.hostPlatform.system}.cuda
    ];
}
