{ config, pkgs, ... }:

{
    nix.settings = {
        extra-substituters = [
            "https://cache.nixos-cuda.org"
            "https://cuda-maintainers.cachix.org"
        ];
        extra-trusted-public-keys = [
            "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
            "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        ];
    };

    boot.kernelModules = [ "nvidia" "nvidia_uvm" ];

    environment.systemPackages = [ pkgs.cudatoolkit ];

    nixpkgs.config.allowUnfree = true;

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
