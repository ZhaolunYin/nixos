{
    boot = {
        # Use the systemd-boot EFI boot loader.
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        loader.systemd-boot.configurationLimit = 5;
    };
}
