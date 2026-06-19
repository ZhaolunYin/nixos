{ pkgs, ... }:

{
	# Enable Tailscale with subnet routing
	services.tailscale = {
		enable = true;
		# Enable subnet routing support
		useRoutingFeatures = "server";
		# Routes to advertise — change to match your local network
		extraUpFlags = [ "--advertise-routes=192.168.1.0/24" ];
	};

	# Open necessary ports for Tailscale
	networking.firewall.allowedUDPPorts = [ 41641 ];
	networking.firewall.allowedTCPPorts = [ 443 ];
}
