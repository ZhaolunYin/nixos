{
    networking.hostName = "nixos"; # Define your hostname.
    # Configure network connections interactively with nmcli or nmtui.

    networking = {
        wireless.iwd = {
            enable = true;
        };
        networkmanager = {
            enable = true;
            wifi.backend = "iwd";
        };
        interfaces = {
            wlp2s0.useDHCP = true;
            enp1s0f0.useDHCP = true;
        };
    };
}
