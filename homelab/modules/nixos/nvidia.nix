{ config, ... }:

{
    nixpkgs.config = {
        allowUnfree = true;
        cudaSupport = true;
    };

    hardware.graphics.enable = true;

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        # Required for modern NVIDIA drivers
        modesetting.enable = true;

        # RTX 5070 requires the proprietary driver
        open = false;

        nvidiaSettings = true;

        # Use the latest stable driver packaged with your kernel
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
}
