{
    imports = [
        ./btop.nix
        ./clipboard.nix
        ./cursor.nix
        ./hypridle.nix
        ./hyprland.nix
        ./hyprlock.nix
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
