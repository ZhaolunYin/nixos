{
    home.file.".xinitrc".text = ''
    setxkbmap -option caps:escape &
    slstatus &
    feh --no-fehbg --bg-fill $HOME/Pictures/Wallpapers/xp-bliss.png
    exec dwm
    '';
    programs.zsh.profileExtra = ''
    if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec startx
    fi
    '';
}
