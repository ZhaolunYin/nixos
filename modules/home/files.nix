{ config, pkgs, flakeRoot, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zhaolun";
  home.homeDirectory = "/home/zhaolun";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/btop".source = "${flakeRoot}/dotfiles/btop";
    ".config/dunst".source = "${flakeRoot}/dotfiles/dunst";
    ".config/fastfetch".source = "${flakeRoot}/dotfiles/fastfetch";
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
    ".config/starship.toml".source = "${flakeRoot}/dotfiles/starship/starship.toml";
    ".config/tmux".source = "${flakeRoot}/dotfiles/tmux";
    ".config/waybar".source = "${flakeRoot}/dotfiles/waybar";
    ".config/yazi".source = "${flakeRoot}/dotfiles/yazi";
    ".zprofile".source = "${flakeRoot}/dotfiles/zsh/.zprofile";
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

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zhaolun/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
