{
    boot = {
        # Use the systemd-boot EFI boot loader.
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;
        initrd.systemd.enable = true;
        # limit to 5 generations
        loader.systemd-boot.configurationLimit = 5;
        # force import root on boot
        zfs.forceImportRoot = true;
    };
}
