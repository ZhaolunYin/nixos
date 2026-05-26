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

tmux new-session -d -s "$session" -c "${PWD:-$HOME}"
tmux attach-session -t "$session"
