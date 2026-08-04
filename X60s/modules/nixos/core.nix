{ pkgs, ... }:

{
    fonts = {
        enableDefaultPackages = false;

        packages = with pkgs; [
            dejavu_fonts
        ];
    };

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
