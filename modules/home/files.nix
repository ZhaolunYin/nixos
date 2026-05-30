{ pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.


  home.file = {
    ".config/gtk-3.0".source = ../../dotfiles/gtk/gtk-3.0;
    ".config/gtk-4.0".source = ../../dotfiles/gtk/gtk-4.0;
    ".gtkrc-2.0".source = ../../dotfiles/gtk/.gtkrc-2.0;
    ".local/share/themes".source = ../../dotfiles/gtk/themes;
    ".icons".source = ../../dotfiles/icons;
    ".config/Kvantum".source = ../../dotfiles/Kvantum/Kvantum;
    ".config/kvantum.kvconfig".source = ../../dotfiles/Kvantum/kvantum.kvconfig;
    ".config/pavucontrol.ini".source = ../../dotfiles/pavucontrol/pavucontrol.ini;
    ".config/yazi".source = ../../dotfiles/yazi;
  };
}
