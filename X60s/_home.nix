{
    home.username = "zhaolun";
    home.homeDirectory = "/home/zhaolun";
    home.stateVersion = "23.11";
    imports = [
        ../share/_home/shell-core.nix
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
    programs.git = {
        enable = true;

        userName = "Zhaolun Yin";
        userEmail = "yinzhaolun2012@gmail.com";

        extraConfig = {
            credential.helper = "cache --timeout=28800";

            init.defaultBranch = "main";

            core = {
                ignorecase = false;
                editor = "nvim";
            };

            commit.gpgsign = false;
        };
    };
}
