{ flakeRoot, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.


  home.file = {
    ".config/gtk-3.0".source = "${flakeRoot}/dotfiles/gtk/gtk-3.0";
    ".config/gtk-4.0".source = "${flakeRoot}/dotfiles/gtk/gtk-4.0";
    ".gtkrc-2.0".source = "${flakeRoot}/dotfiles/gtk/.gtkrc-2.0";
    ".local/share/themes".source = "${flakeRoot}/dotfiles/gtk/themes";
    ".icons".source = "${flakeRoot}/dotfiles/icons";
    ".config/Kvantum".source = "${flakeRoot}/dotfiles/Kvantum/Kvantum";
    ".config/kvantum.kvconfig".source = "${flakeRoot}/dotfiles/Kvantum/kvantum.kvconfig";
    ".config/pavucontrol.ini".source = "${flakeRoot}/dotfiles/pavucontrol/pavucontrol.ini";
    ".config/rofi".source = "${flakeRoot}/dotfiles/rofi";
    ".config/yazi".source = "${flakeRoot}/dotfiles/yazi";
  };
}
