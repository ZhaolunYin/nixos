{ pkgs, inputs, ... }:
let 
    unstable = import inputs.nixpkgs {
        inherit (pkgs.stdenv.hostPlatform) system;
        config = pkgs.config;
    };
in
{
    users.defaultUserShell = pkgs.zsh;

    fonts = {
        enableDefaultPackages = false;

        packages = with pkgs; [
            dejavu_fonts
            unstable.nerd-fonts.symbols-only
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
