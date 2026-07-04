{
    nixpkgs.config = {
        allowUnfree = true;

        permittedInsecurePackages = [
            "broadcom-sta-6.30.223.271-59-6.18.37"
        ];
    };

    hardware.enableRedistributableFirmware = true;
    hardware.broadcom.enable = true;

    networking.networkmanager.enable = true;
}
