{
    imports = [
        ./btop.nix
        ./clipboard.nix
        ./cursor.nix
        ./fastfetch.nix
        ./fcitx.nix
        ./git.nix
        ./gnupg.nix
        ./hypridle.nix
        ./hyprland.nix
        ./hyprlock.nix
        ./kitty.nix
        ./neovim.nix
        ./network.nix
        ./noctalia.nix
        ./packages.nix
        ./shell.nix
        ./tmux.nix
        ./vesktop.nix
        ./vibe.nix
        ./wallpaper.nix
    ];

    home.username = "zhaolun";
    home.homeDirectory = "/home/zhaolun";
    programs.home-manager.enable = true;
}
