{ config, pkgs, flakeRoot, ... }:

{
  # The home.packages option allows you to install Nix packages into your
  # environment.


  home.file = {
    ".config/dunst".source = "${flakeRoot}/dotfiles/dunst";
    ".config/gtk-3.0".source = "${flakeRoot}/dotfiles/gtk/gtk-3.0";
    ".config/gtk-4.0".source = "${flakeRoot}/dotfiles/gtk/gtk-4.0";
    ".gtkrc-2.0".source = "${flakeRoot}/dotfiles/gtk/.gtkrc-2.0";
    ".local/share/themes".source = "${flakeRoot}/dotfiles/gtk/themes";
    ".config/hypr".source = "${flakeRoot}/dotfiles/hypr";
    ".icons".source = "${flakeRoot}/dotfiles/icons";
    ".config/kitty".source = "${flakeRoot}/dotfiles/kitty";
    ".config/Kvantum".source = "${flakeRoot}/dotfiles/Kvantum/Kvantum";
    ".config/kvantum.kvconfig".source = "${flakeRoot}/dotfiles/Kvantum/kvantum.kvconfig";
    ".config/nvim".source = "${flakeRoot}/dotfiles/nvim";
    ".config/pavucontrol.ini".source = "${flakeRoot}/dotfiles/pavucontrol/pavucontrol.ini";
    ".config/rofi".source = "${flakeRoot}/dotfiles/rofi";
    ".config/waybar".source = "${flakeRoot}/dotfiles/waybar";
    ".config/yazi".source = "${flakeRoot}/dotfiles/yazi";
    ".gitconfig".text = ''
	[user]
		email = yinzhaolun2012@gmail.com
		name = Zhaolun Yin
	[credential]
		helper = store
	[init]
		defaultBranch = main
	[core]
		ignorecase = false
		editor = nvim
	[commit]
		gpgsign = false
	'';

  };
}
