-- Key Binds
local main_mod = "SUPER"
local shift_mod = "SUPER + SHIFT"

local terminal = "kitty"
local file_manager = "EDITOR=nvim kitty -e yazi"
local menu = "rofi -show drun"

hl.bind("ALT + T", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + C", hl.dsp.window.close())
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd("kitty -e btop"))
hl.bind(main_mod .. " + V", hl.dsp.window.float())
hl.bind(main_mod .. " + M", hl.dsp.exec_cmd("pkill -USR1 hyprlock 2>/dev/null; hyprshutdown"), { locked = true, long_press = true })
hl.bind(main_mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(main_mod .. " + ALT + L", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(shift_mod .. " + L", function()
    hl.dispatch(hl.dsp.exec_cmd("pgrep hyprlock || hyprlock &"))
    hl.timer(function()
        hl.dispatch(hl.dsp.dpms({ action = "disable" }))
    end, {timeout = 400, type = "oneshot"})
end, { locked = true })


hl.bind(main_mod .. " + P", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(main_mod .. " + F", hl.dsp.exec_cmd("firefox-developer-edition"))
hl.bind(shift_mod .. " + P", hl.dsp.exec_cmd("firefox-developer-edition --private-window"))
hl.bind(shift_mod .. " + C", hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind("SUPER + ALT + C", hl.dsp.exec_cmd('google-chrome-stable --profile-directory="Guest Profile"'))
hl.bind(shift_mod .. " + S", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind(main_mod .. " + W", hl.dsp.exec_cmd("pkill waybar; waybar"))

hl.bind(main_mod .. " + Left", hl.dsp.focus({ direction = "l" }))
hl.bind(main_mod .. " + Right", hl.dsp.focus({ direction = "r" }))
hl.bind(main_mod .. " + Up", hl.dsp.focus({ direction = "u" }))
hl.bind(main_mod .. " + Down", hl.dsp.focus({ direction = "d" }))
hl.bind(shift_mod .. " + Left", hl.dsp.window.move({ direction = "l" }))
hl.bind(shift_mod .. " + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(shift_mod .. " + Up", hl.dsp.window.move({ direction = "u" }))
hl.bind(shift_mod .. " + Down", hl.dsp.window.move({ direction = "d" }))

hl.bind(main_mod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(main_mod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(main_mod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(main_mod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(main_mod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(main_mod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(main_mod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(main_mod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(main_mod .. " + 9", hl.dsp.focus({ workspace = 9 }))

hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1, follow = false }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2, follow = false }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3, follow = false }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4, follow = false }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5, follow = false }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6, follow = false }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7, follow = false }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8, follow = false }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9, follow = false }))


hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { repeating = true, locked = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Mouse Binds
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("mouse:276", hl.dsp.window.close())
hl.bind("mouse:275", hl.dsp.focus({ workspace = 9 }))

-- Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "up", action = "close" })
hl.gesture({ fingers = 3, direction = "swipe", action = "resize" })
hl.gesture({ fingers = 4, direction = "up", action = "float", arg = "float" })
hl.gesture({ fingers = 4, direction = "down", action = "float", arg = "tile" })
hl.gesture({ fingers = 4, direction = "swipe", action = "move" })
