{ pkgs, ... }:
{
    programs.zsh.enable = true;
    users.mutableUsers = false;
    security.sudo.extraRules = [
        {
            users = [ "lab" ];
            commands = [
                {
                    command = "ALL";
                    options = [ "NOPASSWD" ];
                }
            ];
        }
    ];


    users.users.lab = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
        hashedPassword = "$y$j9T$Cur1cOb.2uQWpyl4zQrYZ/$28ebqpkeYmFAI4eHXDIkmt/gNnvIzTyYIJUbdCqIYq6";
    };
    users.users.gaming = {
        isNormalUser = true;
        extraGroups = [ "video" "render" "networkmanager" "uinput" ];
        hashedPassword = "$6$2zvICzUP99Ww87pL$u.o6R7LRjA3m1LdWzWo2u1r6WABZgecEvNqDpk1tQTglDQTFvg9sI5JRcGuFPsKx641l58M.g91w8D7QkgUq90";
        packages = with pkgs; [
            firefox
        ];
    };
    users.users.yxk = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
        hashedPassword = "$6$Dt.CpimXXd3AOKWS$ptEUS2z4TZp8IZjbA1GYF7XBdMb3I0Kx2wugi.6o4VGenV565TrTAK.DmdcdWDnR6rVh6Htl60E.n3ITCkMgU/";
        packages = with pkgs; [
            remmina
            firefox
        ];
    };
    users.users.root.hashedPassword = "!"; 
}
