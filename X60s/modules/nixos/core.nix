{ pkgs, ... }:

{
    fonts.packages = with pkgs; [
        jetbrains-mono
    ];

    security.sudo.extraConfig = "Defaults pwfeedback";

    users.defaultUserShell = pkgs.zsh;
    zramSwap = {
        enable = true;
    };

    services.udisks2.enable = true;

    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];
    system.stateVersion = "23.11";
}
