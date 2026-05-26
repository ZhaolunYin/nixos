require("hyprland.style")
require("hyprland.monitors")
require("hyprland.startup")
require("hyprland.binds")

hl.config({
    dwindle = {
        force_split = 0,
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms  = true,
        allow_session_lock_restore = true,
    },
    xwayland = {
        force_zero_scaling = true,
    },
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:escape,shift:both_capslock",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = false,
            tap_to_click = true,
            scroll_factor = 0.8,
        },
    },
    binds = {
        drag_threshold = 10,
    },
})

hl.workspace_rule({ workspace = "r[1-3]", layout = "dwindle" })
hl.workspace_rule({ workspace = "r[4-8]", layout = "scrolling" })
hl.workspace_rule({ workspace = "9", layout = "monocle" })

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

