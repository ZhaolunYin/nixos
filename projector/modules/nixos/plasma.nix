{
    programs.firefox.enable = true;
    # Enable Plasma 
    services = {
        desktopManager.plasma6.enable = true;

        # Default display manager for Plasma
        displayManager.plasma-login-manager.enable = true;
    };
    services.displayManager.sddm = {
        enable = true;

        # Enables experimental Wayland support
        wayland.enable = true;
    };
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true; # if not already enabled
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment the following
        #jack.enable = true;
    };

    services.udev.extraHwdb = ''
    evdev:input:b0003v0E8Fp2517*
    KEYBOARD_KEY_111b4=reserved
    '';
}
