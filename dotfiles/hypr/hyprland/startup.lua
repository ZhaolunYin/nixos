
-- Environment Variables
hl.env("XCURSOR_SIZE", "36")
hl.env("XCURSOR_THEME", "catppuccin-mocha-mauve-cursors")
hl.env("HYPRCURSOR_SIZE", "36")
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-mauve-cursors")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("LIBVA_DRIVER_NAME", "amd")
hl.env("GNOME_KEYRING_CONTROL", "/run/user/1000/keyring")

-- Startup
hl.on("hyprland.start", function()
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waybar")
    hl.exec_cmd("dunst")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user restart wireplumber")
    hl.exec_cmd("systemctl --user import-environment")
    hl.exec_cmd("wl-clip-persist --clipboard regular")
    hl.exec_cmd("fcitx5 -d")
    hl.exec_cmd("surge server start")
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("exit")
end)
