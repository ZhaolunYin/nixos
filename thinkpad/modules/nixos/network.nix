{
	networking.hostName = "thinkpad"; # Define your hostname.
	# Configure network connections interactively with nmcli or nmtui.

	services.avahi = {
		enable = true;
		nssmdns4 = true;
	};

	networking = {
		wireless.iwd = {
			enable = true;
		};
		networkmanager = {
			enable = true;
			wifi.backend = "iwd";
		};
		nameservers = [
			"1.1.1.1"
			"8.8.8.8"
		];
	};
}
