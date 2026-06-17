{ pkgs, ... }:
{
    home.pointerCursor = {
        package = pkgs.catppuccin-cursors.mochaMauve;
        name = "catppuccin-mocha-mauve-cursors";
        size = 24;
        gtk.enable = true;
        hyprcursor = {
            enable = true;
            size = 24;
        };
    };
}
