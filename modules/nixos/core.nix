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
    nix.settings.experimental-features = [ "nix-command" "flakes"];
    system.stateVersion = "25.11";
}
