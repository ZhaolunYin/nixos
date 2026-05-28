{ pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    programs.firefox.enable = true;
    programs.zsh.enable = true;  

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
        brightnessctl
        fzf
        git
        libnotify
        neovim
        rofi
        tmux
        unzip
        wget
        wl-clipboard
        zip
    ];
}

