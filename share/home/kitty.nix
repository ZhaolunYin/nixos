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

			background_opacity = 0.85;
			window_padding_width = 12;

			scrollback_lines = 10000;
			enable_audio_bell = "no";

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
