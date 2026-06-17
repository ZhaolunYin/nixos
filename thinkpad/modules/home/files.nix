{ pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.


  home.file = {
    ".icons".source = ../../dotfiles/icons;
  };
}
