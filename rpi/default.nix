{ pkgs, ... }:

{
	imports = [
		./tailscale.nix
		../../share/nixos
	];

	boot.kernelModules = [ "iptable_filter" ];

	environment.systemPackages = with pkgs; [
		tailscale
	];
}
