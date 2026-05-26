{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    users.users.zhaolun = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        packages = with pkgs; [
            papirus-icon-theme
        ];
    };
}
