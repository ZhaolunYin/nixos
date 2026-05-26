# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;

  };

  # Users
  users.defaultUserShell = pkgs.zsh;

  users.users.zhaolun = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
        papirus-icon-theme
    ];

  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;  

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
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
  

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; 
}

