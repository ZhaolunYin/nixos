{ pkgs, ... }:
{
    services.comfyui = {
        enable = true;
        package = pkgs.pkgsCuda.comfyui;
        listen = [ "0.0.0.0" "::" ];
        port = 2003;
        extraArgs = [ "--disable-auto-launch" "--lowvram" ];

        models = [
            {
                name = "qwen_image_2.1_int8_convrot.safetensors";
                url = "https://huggingface.co/Comfy-Org/Qwen-Image-2.1/resolve/main/diffusion_models/qwen_image_2.1_int8_convrot.safetensors";
                hash = "sha256-y3QRPLA/rs15YRsB/X/WQvCqYNbwuVCGq+4hTXXqpX0=";
                installPaths = "diffusion_models";
            }
        ];
    };
}
