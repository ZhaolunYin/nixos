# Recursive so the directory stays writable: wallpapers dropped in by hand then
# show up in Noctalia's picker instead of hitting a read-only store symlink.
{
    home.file."Pictures/Wallpapers" = {
        recursive = true;
        source = ./Wallpapers;
    };
}
