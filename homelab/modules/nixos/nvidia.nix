{ config, ... }:

{
    nix.settings = {
        substituters = [
            "https://cache.nixos-cuda.org"
        ];
        trusted-public-keys = [
            "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
        ];
    };

    nixpkgs.config = {
        allowUnfree = true;
        cudaSupport = true;
    };

    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        # Required for modern NVIDIA drivers
        modesetting.enable = true;

        open = true;

        nvidiaSettings = true;

        # Use the latest stable driver packaged with your kernel
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
}
