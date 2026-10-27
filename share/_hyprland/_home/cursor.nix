{ pkgs, ... }:

{
    # One size for native (hyprcursor) and XWayland/GTK: home-manager's
    # pointerCursor module exports XCURSOR_* and HYPRCURSOR_* itself, so nothing
    # else in the session should set them.
    home.pointerCursor = {
        enable = true;
        package = pkgs.catppuccin-cursors.mochaMauve;
        name = "catppuccin-mocha-mauve-cursors";
        size = 36;
        gtk.enable = true;
        hyprcursor = {
            enable = true;
            size = 36;
        };
    };
}
