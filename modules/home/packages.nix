{ pkgs, ... }:

{
    home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
        bat
        duf
        dunst
        dust
        eza
        fd
        google-chrome
        grimblast
        hypridle
        hyprlock
        hyprpaper
        hyprshutdown
        kiwix
        networkmanagerapplet
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        papirus-icon-theme
        pass
        pinentry-curses
        procs
        ripgrep
        speedtest
        trash-cli
        waybar
        yazi
    ];
}
