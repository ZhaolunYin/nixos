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
            {
                name = "qwen_image_2.1_vae_bf16.safetensors";
                url = "https://huggingface.co/Comfy-Org/Qwen-Image-2.1/resolve/main/vae/qwen_image_2.1_vae_bf16.safetensors";
                hash = "sha256-uyH3RzBR4aw2hRXdPy4VzUTXoRdI7ogj4d3KPkh2t8k=";
                installPaths = "vae";
            }
            {
                name = "qwen3vl_8b_int8_convrot.safetensors";
                url = "https://huggingface.co/Comfy-Org/Qwen-Image-2.1/resolve/main/text_encoders/qwen3vl_8b_int8_convrot.safetensors";
                hash = "sha256-i/0PbhKr8tLWl+zIiOXpCw1nQdZwjwV5n1OvpWBFLo8=";
                installPaths = "text_encoders";
            }
        ];
    };
}
