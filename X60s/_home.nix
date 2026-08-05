{
    home.username = "zhaolun";
    home.homeDirectory = "/home/zhaolun";
    home.stateVersion = "23.11";
    imports = [
        ../share/_home/shell-core.nix
        ../share/_home/git.nix
        ../share/_home/gnupg.nix
    ];
    home.file.".xinitrc".text = ''
    exec dwm
    '';
    programs.zsh.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec startx
    fi
    '';
}
