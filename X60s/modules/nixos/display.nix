{ pkgs, ... }:
{
    services.xserver = {
        enable = true;
        windowManager.dwm.enable = true;
        displayManager.startx.enable = true;
        videoDrivers = [ "intel" ];
    };
    system.activationScripts.xinitrc.text = ''
        cat > /home/zhaolun/.xinitrc <<'EOF'
        exec dwm
        EOF
        chown zhaolun:users /home/zhaolun/.xinitrc
        chmod 644 /home/zhaolun/.xinitrc
    '';
    environment.etc."X11/xorg.conf.d/20-intel.conf".text = ''
        Section "Device"
            Identifier "Intel Graphics"
            Driver "intel"
        EndSection
    '';
    environment.systemPackages = with pkgs; [
        xorg.xf86videointel
    ];
}
