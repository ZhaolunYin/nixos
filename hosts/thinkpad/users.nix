{
    users.mutableUsers = false;
    users.users.zhaolun = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
    };
    users.users.root.hashedPassword = "!"; 
}
