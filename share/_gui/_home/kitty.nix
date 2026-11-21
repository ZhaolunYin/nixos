{ config, ... }:

{
    home.file.".local/bin/launch-tmux" = {
        executable = true;
        text = ''
            #!/usr/bin/env bash
            set -euo pipefail
            n=0
            while tmux has-session -t "k-$n" 2>/dev/null; do
                n=$((n + 1))
            done
            session="k-$n"
            cleanup() {
                if ! tmux has-session -t "$session" 2>/dev/null; then
                    return
                fi
                keep="$(tmux show-options -t "$session" -vq @keep_session 2>/dev/null || true)"
                if [[ "$keep" == "1" ]]; then
                    tmux set-option -t "$session" -u @keep_session 2>/dev/null || true
                    return
                fi
                tmux kill-session -t "$session" 2>/dev/null || true
            }
            trap cleanup EXIT HUP INT TERM
            tmux new-session -d -s "$session" -c "${"PWD:-$HOME"}"
            tmux attach-session -t "$session"
        '';
    };

    programs.kitty = {
        enable = true;

        font = {
            name = "JetBrainsMono Nerd Font";
            size = 11.5;
        };
        autoThemeFiles = {
            light = "Catppuccin-Mocha";
            dark = "Catppuccin-Mocha";
            noPreference = "Catppuccin-Mocha";
        };
        settings = {
            cursor_shape = "beam";
            cursor_blink_interval = 0.5;
            # Mauve beam, crust text under it: the theme's own cursor colours leave
            # the glyph unreadable.
            cursor = "#cba6f7";
            cursor_text_color = "#11111b";
            # 0 disables pointer hiding altogether (kitty's default is 3.0s; any
            # positive number hides the pointer that many seconds *after it stops
            # moving*, which is why it vanished while sitting still). tmux is
            # innocent here: it never touches the host cursor.
            mouse_hide_wait = 0;

            # Unfocused terminals fade back the way Hyprland dims inactive windows.
            inactive_text_alpha = 0.8;

            background_opacity = 0.88;
            window_padding_width = 12;

            selection_foreground = "#1e1e2e";
            selection_background = "#cba6f7";
            url_color = "#89b4fa";

            scrollback_lines = 10000;
            enable_audio_bell = "no";

            # Font size on demand.
            "map ctrl+equal" = "change_font_size all +0.5";
            "map ctrl+minus" = "change_font_size all -0.5";
            "map ctrl+0" = "change_font_size all 0";

            shell = "${config.home.homeDirectory}/.local/bin/launch-tmux";

            # Leave multiplexing to tmux
            "map ctrl+shift+enter" = "no_op";
            "map ctrl+shift+t" = "no_op";
            "map ctrl+shift+right" = "no_op";
            "map ctrl+shift+left" = "no_op";
            "map ctrl+shift+]" = "no_op";
            "map ctrl+shift+[" = "no_op";
            "map ctrl+shift+n" = "no_op";
            "map ctrl+shift+q" = "no_op";
            "map ctrl+shift+w" = "no_op";
        };
    };
}
