{
    imports = [
        ./btop.nix
        ./dunst.nix
        ./fastfetch.nix
        ./files.nix
        ./git.nix
        ./gnupg.nix
        ./kitty.nix
        ./packages.nix
        ./neovim.nix
        ./shell.nix
        ./tmux.nix
        ./vesktop.nix
        ./waybar.nix
    ];
    home.username = "zhaolun";
    home.homeDirectory = "/home/zhaolun";
    programs.home-manager.enable = true;

}
