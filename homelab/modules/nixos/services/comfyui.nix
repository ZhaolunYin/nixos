{
    services.comfyui = {
        enable = true;
        acceleration = "cuda";
        listen = "0.0.0.0";
        port = 2003;

        models = [
            {
                name = "qwen_image_2.1_int8_convrot.safetensors";
                url = "https://huggingface.co/Comfy-Org/Qwen-Image-2.1/resolve/main/diffusion_models/qwen_image_2.1_int8_convrot.safetensors";
                hash = "";
                installPaths = "diffusion_models";
            }
        ];
    };
}
