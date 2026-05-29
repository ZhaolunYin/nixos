{
    users.mutableUsers = false;
    users.users.zhaolun = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        hashedPassword = "$y$j9T$Cur1cOb.2uQWpyl4zQrYZ/$28ebqpkeYmFAI4eHXDIkmt/gNnvIzTyYIJUbdCqIYq6";
    };
    users.users.root.hashedPassword = "!"; 
}
