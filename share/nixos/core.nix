{ pkgs, ... }:

{
  security.sudo.extraConfig = "Defaults pwfeedback";

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Powers on the controller on startup
  };

  users.defaultUserShell = pkgs.zsh;
  zramSwap = {
    enable = true;
  };

  powerManagement.enable = true;
  services.udisks2.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  system.stateVersion = "26.05";
}
