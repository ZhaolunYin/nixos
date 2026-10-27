{ pkgs, ... }:

{
    # Widget theme, icons and fonts for GTK apps (Qt follows via gtk3 theme).
    # Without an explicit iconTheme, Papirus was installed but never selected.
    qt.platformTheme.name = "gtk3";

    gtk = {
        enable = true;

        # Mauve accent, same as the Hyprland borders and the cursor theme.
        theme = {
            name = "Catppuccin-Mocha-Standard-Mauve-dark";
            package = pkgs.catppuccin-gtk.override {
                accents = [ "mauve" ];
                variant = "mocha";
            };
        };

        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };

        font = {
            name = "JetBrainsMono Nerd Font";
            size = 11.0;
        };
    };

    # Font defaults nobody configures per-app: hint at slight (no fuzzy stems),
    # and fall back to a CJK face instead of tofu when the UI font has no Han
    # glyphs -- otherwise fc-match answers DejaVu and Han renders as boxes.
    fonts.fontconfig = {
        enable = true;
        hinting = "slight";
        antialiasing = true;
        subpixelRendering = "rgb";

        defaultFonts = {
            monospace = [
                "JetBrainsMono Nerd Font Mono"
                "Noto Sans Mono CJK SC"
            ];
            sansSerif = [ "Noto Sans" "Noto Sans CJK SC" ];
            serif = [ "Noto Serif" "Noto Serif CJK SC" ];
            emoji = [ "Noto Color Emoji" ];
        };
    };
}
