{
    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };
    security.pam.services.hyprlock.fprintAuth = false;

    # Qt apps otherwise fall back to stock Fusion widgets
    qt = {
        enable = true;
        platformTheme = "qt5ct";
    };
}
