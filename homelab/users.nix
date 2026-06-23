{ pkgs, ... }:
{
    programs.zsh.enable = true;
    users.mutableUsers = false;
    users.users.lab = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        hashedPassword = "$y$j9T$Cur1cOb.2uQWpyl4zQrYZ/$28ebqpkeYmFAI4eHXDIkmt/gNnvIzTyYIJUbdCqIYq6";
    };
    users.users.yxk = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" ];
        hashedPassword = "$6$Dt.CpimXXd3AOKWS$ptEUS2z4TZp8IZjbA1GYF7XBdMb3I0Kx2wugi.6o4VGenV565TrTAK.DmdcdWDnR6rVh6Htl60E.n3ITCkMgU/";
        packages = with pkgs; [
            remmina
            qemu
            quickemu
        ];
    };
    users.users.root.hashedPassword = "!"; 
}
