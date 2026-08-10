{ pkgs, ... }:

{
    nixpkgs.config.allowUnfree = true;

    programs.firefox.enable = true;
    programs.zsh.enable = true;  
    programs.fuse.userAllowOther = true;
    programs.steam.enable = true;
    security.polkit.enable = true;
    services.fwupd.enable = true;
    services.upower.enable = true;
    documentation.dev.enable = true;

    # List packages installed in system profile.
    # You can use https://search.nixos.org/ to find more packages (and options).
    environment.systemPackages = with pkgs; [
        brightnessctl
        cargo
        fzf
        gcc
        git
        gnumake
        jq
        libnotify
        lm_sensors
        man-pages
        man-pages-posix
        OVMF
        pkg-config
        qemu
        rustc
        rustup
        tmux
        unzip
        wget
        wl-clipboard
        zip
    ];
}

