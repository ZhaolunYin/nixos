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
    environment.systemPackages = with pkgs; [
        xorg.xf86videointel
    ];
}
