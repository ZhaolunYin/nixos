{ config, pkgs, ... }:

{
	boot = {
		extraModulePackages = [ config.boot.kernelPackages.evdi ];
		initrd.kernelModules = [ "evdi" ];
	};
	services.xserver.videoDrivers = [ "displaylink" "modesetting" ];

	systemd.services.displaylink-server = {
		enable = true;
		requires = [ "systemd-udevd.service" ];
		after    = [ "systemd-udevd.service" ];
		wantedBy = [ "multi-user.target" ];
		serviceConfig = {
			Type       = "simple";
			ExecStart  = "${pkgs.displaylink}/bin/DisplayLinkManager";
			User       = "root";
			Group      = "root";
			Restart    = "on-failure";
			RestartSec = 5;
		};
	};
	environment.variables = {
		WLR_EVDI_RENDER_DEVICE = "/dev/dri/card1";
	};
}

