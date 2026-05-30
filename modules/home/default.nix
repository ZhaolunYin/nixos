{
    imports = [
        ./btop.nix
        ./clipboard.nix
        ./dunst.nix
        ./fastfetch.nix
        ./files.nix
        ./fcitx.nix
        ./git.nix
        ./gnupg.nix
        ./hypridle.nix
        ./hyprland.nix
        ./hyprlock.nix
        ./hyprpaper.nix
        ./hyprpolkitagent.nix
        ./kitty.nix
        ./packages.nix
        ./neovim.nix
        ./network.nix
        ./rofi.nix
        ./shell.nix
        ./tmux.nix
        ./vesktop.nix
        ./wallpaper.nix
        ./waybar.nix
    ];
    home.username = "zhaolun";
    home.homeDirectory = "/home/zhaolun";
    programs.home-manager.enable = true;

}
