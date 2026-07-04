{ config, lib, pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    hardware.enableRedistributableFirmware = true;

    boot.extraModulePackages = [
        config.boot.kernelPackages.broadcom_sta
    ];

    boot.initrd.kernelModules = [ "wl" ];

    boot.blacklistedKernelModules = [
        "b43"
        "bcma"
        "brcmsmac"
        "brcmfmac"
        "ssb"
    ];

    networking.networkmanager.enable = true;
}
