{
    imports = [
        ./btop.nix
        ./clipboard.nix
        ./cursor.nix
        ./fcitx.nix
        ./firefox.nix
        ./gnupg.nix
        ./hypridle.nix
        ./hyprland.nix
        ./hyprlock.nix
        ./network.nix
        ./noctalia.nix
        ./packages.nix
        ./vesktop.nix
        ./vibe.nix
        ./wallpaper.nix
    ];

    home.username = "zhaolun";
    home.homeDirectory = "/home/zhaolun";
    programs.home-manager.enable = true;
}
