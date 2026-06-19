{ pkgs, ... }:

{
	# Enable Tailscale with subnet routing
	services.tailscale = {
		enable = true;
		# Routes to advertise — change to match your local network
		advertiseRoutes = [ "192.168.1.0/24" ];
	};

	# Enable IP forwarding (required for subnet router)
	net.ipv4.ip_forward = 1;
	net.ipv6.conf.all.forwarding = true;

	# Open necessary ports for Tailscale
	networking.firewall.allowedUDPPorts = [ 41641 ];
	networking.firewall.allowedTCPPorts = [ 443 ];

	# Allow forwarding through Tailscale interface
	networking.firewall.extraCommands = ''
		iptables -A FORWARD -i tailscale0 -j ACCEPT
		iptables -A FORWARD -o tailscale0 -j ACCEPT
	'';
}
