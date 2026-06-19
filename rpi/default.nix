{ pkgs, config, lib, ... }:

{
    imports = [
        ./modules/nixos
        ../share/nixos
    ];
    boot.loader.grub.enable = false;
    programs.zsh.enable = true;
    users.users.admin = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        hashedPassword = "$y$j9T$Cur1cOb.2uQWpyl4zQrYZ/$28ebqpkeYmFAI4eHXDIkmt/gNnvIzTyYIJUbdCqIYq6";
    };
    networking.hostName = "rpi";
}
