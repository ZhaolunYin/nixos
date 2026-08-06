{
    security.rtkit.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = false; # i686, so not needed
        pulse.enable = true;
    };
}
