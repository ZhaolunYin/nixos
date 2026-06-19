{ config, ... }:

{
	boot = {
		# Use the systemd-boot EFI boot loader.
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		initrd.systemd.enable = true;
		loader.systemd-boot.configurationLimit = 10;
	};
}
