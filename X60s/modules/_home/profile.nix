{
    home.file.".xinitrc".text = ''
    setxkbmap -option caps:escape &
    slstatus &
    exec dwm
    '';
    programs.zsh.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec startx
    fi
    '';
}
