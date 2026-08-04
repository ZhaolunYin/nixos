{
    services.xserver = {
        enable = true;
        windowManager.dwm.enable = true;
        displayManager.lightdm.enable = false;
        videoDrivers = [ "intel" ];
    };
    system.activationScripts.xinitrc.text = ''
        cat > /home/zhaolun/.xinitrc <<'EOF'
        exec dwm
        EOF
        chown zhaolun:users /home/zhaolun/.xinitrc
        chmod 644 /home/zhaolun/.xinitrc
    '';
}
