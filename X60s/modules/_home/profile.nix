{
    home.file.".xinitrc".text = ''
    slstatus &
    exec dwm
    '';
    programs.zsh.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec startx
    fi
    '';
}
