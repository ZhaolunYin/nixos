{ pkgs, config, lib, ... }:

{
    imports = [
        ./modules/nixos
        ../share/nixos
    ];
    programs.zsh.enable = true;
    users.mutableUsers = false;
    users.users.projector = {
        isNormalUser = true;
        hashedPassword = "!";
    };
    users.users.root.hashedPassword = "$y$j9T$Cur1cOb.2uQWpyl4zQrYZ/$28ebqpkeYmFAI4eHXDIkmt/gNnvIzTyYIJUbdCqIYq6";
    networking.hostName = "projector";
}
