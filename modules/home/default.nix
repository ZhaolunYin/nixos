{
    imports = [
        ./shell.nix
        ./tmux.nix
        ./files.nix
        ./btop.nix
        ./fastfetch.nix
        ./packages.nix
    ];
    home.username = "zhaolun";
    home.homeDirectory = "/home/zhaolun";
    home.stateVersion = "25.11";
    programs.home-manager.enable = true;

}
