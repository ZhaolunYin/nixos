{
    users.users.zhaolun = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
    };
    users.users.root = {
        hashedPassword = "!"; # Disables password login for root
    };
}
