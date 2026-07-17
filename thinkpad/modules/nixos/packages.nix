{ pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    programs.firefox.enable = true;
    programs.zsh.enable = true;  
    security.polkit.enable = true;
    services.fwupd.enable = true;
    services.upower.enable = true;
    documentation.dev.enable = true;

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
        brightnessctl
        fzf
        gcc
        git
        gnumake
        libnotify
        lm_sensors
        man-pages
        man-pages-posix
        neovim
        nodejs
        tmux
        unzip
        wget
        wl-clipboard
        zip
    ];
}

