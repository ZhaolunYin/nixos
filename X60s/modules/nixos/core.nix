{ pkgs, ... }:

{
    users.defaultUserShell = pkgs.zsh;

    fonts = {
        enableDefaultPackages = false;

        packages = with pkgs; [
            dejavu_fonts
        ];
    };

    security.sudo.extraConfig = "Defaults pwfeedback";

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
