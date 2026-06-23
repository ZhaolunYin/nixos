{ config, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    hardware.graphics = {
        enable = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
        modesetting.enable = true;

        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = false;

        nvidiaSettings = true;

        package = config.boot.kernelPackages.nvidiaPackages.stable;
        nixpkgs.config.cudaSupport = true;
        # RTX 5070 is sm_120 cuda architecture
        nixpkgs.config.cudaCapabilities = [ "sm_120" ]; 
    };
}

