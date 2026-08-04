{
    services.xserver = {
        enable = true;
        windowManager.dwm.enable = true;
        displayManager.lightdm.enable = false;
    };
    environment.etc."skel/.xinitrc".text = ''
        exec dwm
    '';
}
