{ lib, ... }:

{
    xdg.configFile."hypr/hyprland.lua".text = ''
        -- Colors
        local mauve    = "rgb(cba6f7)"
        local rosewater = "rgb(f5e0dc)"

        -- General
        hl.config({
            general = {
                gaps_in  = 6,
                gaps_out = 12,
                border_size = 2,
                ["col.active_border"]   = mauve,
                ["col.inactive_border"] = rosewater,
            },
            decoration = {
                rounding = 12,
                blur = {
                    enabled = true,
                    size = 8,
                    passes = 1,
                },
                shadow = {
                    enabled = true,
                    range = 20,
                    render_power = 3,
                    color = "rgba(000000aa)",
                },
            },
            dwindle = {
                force_split = 0,
            },
            misc = {
                force_default_wallpaper  = -1,
                disable_hyprland_logo    = true,
                mouse_move_enables_dpms  = true,
                key_press_enables_dpms   = true,
                allow_session_lock_restore = true,
            },
            xwayland = {
                force_zero_scaling = true,
            },
            input = {
                kb_layout  = "us",
                kb_options = "caps:escape,shift:both_capslock",
                follow_mouse = 1,
                sensitivity  = 0,
                touchpad = {
                    natural_scroll = false,
                    tap_to_click   = true,
                    scroll_factor  = 0.8,
                },
            },
            binds = {
                drag_threshold = 10,
            },
        })

        -- Monitors
        hl.monitor({
            output = "desc: Dell Inc. DELL P2714H NV2C44CM1BWS",
            mode = "1920x1080@60",
            position = "0x0",
            scale = 1,
        })
        hl.monitor({
            output = "eDP-1",
            mode = "2880x1800@60",
            position = "1920x0",
            scale = 2,
        })

        -- Bezier Curves
        hl.curve("snappy",     { type = "bezier", points = { { 0.18, 1.0  }, { 0.28, 1.0  } } })
        hl.curve("smooth",     { type = "bezier", points = { { 0.22, 1.0  }, { 0.36, 1.0  } } })
        hl.curve("decel",      { type = "bezier", points = { { 0.12, 0.95 }, { 0.2,  1.0  } } })
        hl.curve("softsnap",   { type = "bezier", points = { { 0.16, 1.0  }, { 0.3,  1.02 } } })
        hl.curve("accelerate", { type = "bezier", points = { { 0.4,  0.0  }, { 1.0,  1.0  } } })

        -- Animations
        hl.animation({ leaf = "global",         enabled = true, speed = 3, bezier = "default"  })
        hl.animation({ leaf = "border",         enabled = true, speed = 3, bezier = "snappy"   })
        hl.animation({ leaf = "windows",        enabled = true, speed = 3, bezier = "softsnap",  style = "slide"        })
        hl.animation({ leaf = "windowsIn",      enabled = true, speed = 3, bezier = "smooth",    style = "popin 94%"    })
        hl.animation({ leaf = "windowsOut",     enabled = true, speed = 3, bezier = "accelerate",style = "popin 90%"    })
        hl.animation({ leaf = "fade",           enabled = true, speed = 3, bezier = "decel"    })
        hl.animation({ leaf = "fadeIn",         enabled = true, speed = 2, bezier = "decel"    })
        hl.animation({ leaf = "fadeOut",        enabled = true, speed = 2, bezier = "accelerate" })
        hl.animation({ leaf = "layers",         enabled = true, speed = 3, bezier = "snappy"   })
        hl.animation({ leaf = "layersIn",       enabled = true, speed = 3, bezier = "smooth",    style = "fade"         })
        hl.animation({ leaf = "layersOut",      enabled = true, speed = 2, bezier = "accelerate",style = "fade"         })
        hl.animation({ leaf = "fadeLayersIn",   enabled = true, speed = 2, bezier = "decel"    })
        hl.animation({ leaf = "fadeLayersOut",  enabled = true, speed = 3, bezier = "accelerate" })
        hl.animation({ leaf = "workspaces",     enabled = true, speed = 3, bezier = "snappy",    style = "slidefade 8%" })
        hl.animation({ leaf = "workspacesIn",   enabled = true, speed = 3, bezier = "smooth",    style = "slidefade 8%" })
        hl.animation({ leaf = "workspacesOut",  enabled = true, speed = 1, bezier = "accelerate",style = "slidefade 8%" })
        hl.animation({ leaf = "zoomFactor",     enabled = true, speed = 2, bezier = "snappy"   })

        -- Workspace Rules
        hl.workspace_rule({ workspace = "r[1-3]", layout = "dwindle"   })
        hl.workspace_rule({ workspace = "r[4-8]", layout = "scrolling" })
        hl.workspace_rule({ workspace = "9",      layout = "monocle"   })

        -- Window Rules
        hl.window_rule({
            name    = "kitty-hud",
            match   = { class = "^(kitty)$", focus = true },
            float   = true,
            center  = true,
            size    = { 1000, 650 },
            opacity = "0.95 override 0.95 override",
        })
        hl.window_rule({
            name    = "terminal-clarity",
            match   = { class = "^(kitty)$" },
            opacity = "0.97 override 0.97 override",
        })
        hl.window_rule({
            name    = "global-opacity",
            match   = { class = ".*" },
            opacity = "0.92 override 0.75 override",
        })
        hl.window_rule({
            name           = "suppress-maximize-events",
            match          = { class = ".*" },
            suppress_event = "maximize",
        })

        -- Device
        hl.device({
            name        = "epic-mouse-v1",
            sensitivity = -0.5,
        })

        -- Keybinds
        local main_mod  = "SUPER"
        local shift_mod = "SUPER + SHIFT"

        hl.bind("ALT + T",               hl.dsp.exec_cmd("kitty"))
        hl.bind(main_mod  .. " + C",     hl.dsp.window.close())
        hl.bind(main_mod  .. " + E",     hl.dsp.exec_cmd("EDITOR=nvim kitty -e yazi"))
        hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("kitty -e btop"))
        hl.bind(main_mod  .. " + V",     hl.dsp.window.float())
        hl.bind(main_mod  .. " + M",     hl.dsp.exec_cmd("pkill -USR1 hyprlock 2>/dev/null; hyprshutdown"), { locked = true, long_press = true })
        hl.bind(main_mod  .. " + R",     hl.dsp.exec_cmd("rofi -show drun"))
        hl.bind(main_mod  .. " + L",     hl.dsp.exec_cmd("hyprlock"))
        hl.bind(main_mod  .. " + ALT + L", hl.dsp.exec_cmd("systemctl suspend"))
        hl.bind(shift_mod .. " + L",     function()
            hl.dispatch(hl.dsp.exec_cmd("pgrep hyprlock || hyprlock &"))
            hl.timer(function()
                hl.dispatch(hl.dsp.dpms({ action = "disable" }))
            end, { timeout = 400, type = "oneshot" })
        end, { locked = true })
        hl.bind(shift_mod  .. " + ALT + L", hl.dsp.exec_cmd("systemctl hibernate"))
        hl.bind(main_mod  .. " + P",     hl.dsp.window.pseudo())
        hl.bind(main_mod  .. " + J",     hl.dsp.layout("togglesplit"))
        hl.bind(main_mod  .. " + F",     hl.dsp.exec_cmd("firefox"))
        hl.bind(shift_mod .. " + P",     hl.dsp.exec_cmd("firefox --private-window"))
        hl.bind(shift_mod .. " + C",     hl.dsp.exec_cmd("google-chrome-stable"))
        hl.bind("SUPER + ALT + C",       hl.dsp.exec_cmd('google-chrome-stable --profile-directory="Guest Profile"'))
        hl.bind(shift_mod .. " + S",     hl.dsp.exec_cmd("grimblast copy area"))
        hl.bind(main_mod  .. " + W",     hl.dsp.exec_cmd("pkill waybar; waybar"))

        -- Focus
        hl.bind(main_mod .. " + Left",  hl.dsp.focus({ direction = "l" }))
        hl.bind(main_mod .. " + Right", hl.dsp.focus({ direction = "r" }))
        hl.bind(main_mod .. " + Up",    hl.dsp.focus({ direction = "u" }))
        hl.bind(main_mod .. " + Down",  hl.dsp.focus({ direction = "d" }))

        -- Move windows
        hl.bind(shift_mod .. " + Left",  hl.dsp.window.move({ direction = "l" }))
        hl.bind(shift_mod .. " + Right", hl.dsp.window.move({ direction = "r" }))
        hl.bind(shift_mod .. " + Up",    hl.dsp.window.move({ direction = "u" }))
        hl.bind(shift_mod .. " + Down",  hl.dsp.window.move({ direction = "d" }))

        -- Workspaces
        for i = 1, 9 do
            hl.bind(main_mod  .. " + " .. i, hl.dsp.focus({ workspace = i }))
            hl.bind(shift_mod .. " + " .. i, hl.dsp.window.move({ workspace = i, follow = false }))
        end

        -- Media / brightness (repeating + locked)
        hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { repeating = true, locked = true })
        hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { repeating = true, locked = true })
        hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { repeating = true, locked = true })
        hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { repeating = true, locked = true })
        hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { repeating = true, locked = true })
        hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { repeating = true, locked = true })
        hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),        { locked = true })
        hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
        hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
        hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

        -- Mouse
        hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
        hl.bind(main_mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
        hl.bind(main_mod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true })
        hl.bind(main_mod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true })
        hl.bind("mouse:276", hl.dsp.window.close())
        hl.bind("mouse:275", hl.dsp.focus({ workspace = 9 }))

        -- Gestures
        hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
        hl.gesture({ fingers = 3, direction = "up",         action = "close"     })
        hl.gesture({ fingers = 3, direction = "swipe",      action = "resize"    })
        hl.gesture({ fingers = 4, direction = "up",         action = "float",  arg = "float" })
        hl.gesture({ fingers = 4, direction = "down",       action = "float",  arg = "tile"  })
        hl.gesture({ fingers = 4, direction = "swipe",      action = "move"      })
    '';
}
