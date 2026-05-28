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

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
    ];

    users.defaultUserShell = pkgs.zsh;
    zramSwap.enable = true; # Creates a zram block device and uses it as a swap device
    nix.settings.experimental-features = [ "nix-command" "flakes"];
    system.stateVersion = "26.05";
}
