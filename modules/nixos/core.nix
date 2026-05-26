{ pkgs, ... }:

{
    # Set your time zone.
    time.timeZone = "Europe/London";

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
    ];
    
    users.defaultUserShell = pkgs.zsh;
    nix.settings.experimental-features = [ "nix-command" "flakes"];
    system.stateVersion = "25.11";
}
