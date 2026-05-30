{ pkgs, ... }:

{
    # Set your time zone.
    time.timeZone = "Europe/London";

    i18n = {
        defaultLocale = "en_GB.UTF-8";
        extraLocaleSettings = {
            LC_ALL = "en_GB.UTF-8";
        };
    };

    security.sudo.extraConfig = "Defaults pwfeedback";

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
    ];

    hardware.bluetooth = {
        enable = true;
        powerOnBoot = true; # Powers on the controller on startup
    };

    users.defaultUserShell = pkgs.zsh;
    zramSwap = {
        enable = true;
    };

    powerManagement.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes"];
    system.stateVersion = "26.05";
}
