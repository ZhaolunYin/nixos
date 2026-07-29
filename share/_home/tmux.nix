{ pkgs, ... }:

{
    programs.tmux = {
        enable = true;
        mouse = true;
        baseIndex = 1;
        prefix = "C-Space";
        keyMode = "vi";
        sensibleOnTop = true;
        terminal = "tmux-256color";

        plugins = with pkgs.tmuxPlugins; [
            sensible
            yank
            {
                plugin = catppuccin;
                extraConfig = ''
          set -g @catppuccin_flavor 'mocha'
          set -g @catppuccin_window_status_style "rounded"
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
                '';
            }
        ];

        extraConfig = ''
            set -g default-command "$\{SHELL}"
            set -g extended-keys on
            set -g extended-keys-format csi-u

            # titles
            set -g set-titles on
            set -g set-titles-string '#{pane_current_command}'

            # pane base index
            set -g pane-base-index 1
            set-window-option -q pane-base-index 1
            set-option -g renumber-windows on

            # window switching
            bind -n M-H previous-window
            bind -n M-L next-window

            # copy
            bind-key -T copy-mode-vi y   send-keys -X copy-selection-and-cancel

            # split in current dir
            bind '"' split-window -v -c "#{pane_current_path}"
            bind % split-window -h -c "#{pane_current_path}"

            # detach but keep session
            bind d set-option @keep_session 1 \; detach-client
        '';
    };
}
