{ config, ... }:

{
    boot = {
        # Use the systemd-boot EFI boot loader.
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        initrd.systemd.enable = true;
        loader.systemd-boot.configurationLimit = 10;
        resumeDevice = (builtins.head config.swapDevices).device;
        extraModulePackages = [ config.boot.kernelPackages.evdi ];
        initrd.kernelModules = [ "evdi" ];
    };
}
