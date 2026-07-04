{ config, ... }:

{
    nixpkgs.config = {
        allowUnfree = true;

        permittedInsecurePackages = [
            "broadcom-sta-6.30.223.271-59-6.18.37"
        ];
    };

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
