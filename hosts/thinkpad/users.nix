{
    users.users.zhaolun = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
    };
    users.users.root = {
        hashedPassword = "!"; # Disables password login for root
    };
}
