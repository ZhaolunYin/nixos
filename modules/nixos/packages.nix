{ pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    programs.firefox.enable = true;
    programs.zsh.enable = true;  

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
        neovim
        wget
        google-chrome
        kitty
        tmux
        waybar
        git
        hyprpaper
        hypridle
        hyprshutdown
        hyprlock
        rofi
        stow
        pass
        gnupg
        pinentry-curses
        gtk3
        gtk4
        wl-clipboard
        btop
        dunst
        fastfetch
        grimblast
        networkmanagerapplet
        starship
        eza
        bat
        ripgrep
        fd
        dust
        duf
        procs
        trash-cli
        fzf
        zip
        unzip
        zoxide
    ];
}
