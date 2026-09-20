{ pkgs, ... }:
{
    wayland.windowManager.sway = {
        enable = true;
        package = pkgs.swayfx;

        config = {
            # Modifier
            modifier = "Mod4";

            # Terminal
            terminal = "kitty";

            # Application launcher
            menu = "noctalia msg panel-toggle launcher";

            # Gaps
            gaps = {
                inner = 3;
                outer = 6;
                smartGaps = false;
            };

            # Borders
            window = {
                border = 2;
                titlebar = false;
            };

            # Focus
            focus = {
                followMouse = "yes";
                mouseWarping = false;
            };

            # Keyboard
            input = {
                "*" = {
                    xkb_layout = "us";
                    xkb_options = "caps:escape,shift:both_capslock";
                    tap = "enabled";
                    natural_scroll = "disabled";
                };

                "type:touchpad" = {
                    tap = "enabled";
                    natural_scroll = "disabled";
                    scroll_factor = "0.8";
                };

                "epic-mouse-v1" = {
                    pointer_accel = "-0.5";
                };
            };

            # Outputs
            output = {
                "eDP-1" = {
                    mode = "2880x1800@60Hz";
                    pos = "1920 0";
                    scale = "2";
                };

                "*" = {
                    mode = "1920x1080@60Hz";
                    pos = "0 0";
                    scale = "1";
                };
            };

            # Workspaces
            workspaceAutoBackAndForth = false;

            # Keybindings
            keybindings = let
                mod = "Mod4";
            shift = "Mod4+Shift";
            in {
                # Applications
                "Alt+t" = "exec kitty";
                "${mod}+c" = "kill";
                "${mod}+e" = "exec EDITOR=nvim kitty -e yazi";
                "Ctrl+Shift+Escape" = "exec kitty -e btop";

                "${mod}+f" = "exec firefox";
                "${shift}+p" = "exec firefox --private-window";
                "${shift}+c" = "exec google-chrome-stable";
                "${mod}+Alt+c" =
                    "exec google-chrome-stable --profile-directory=\"Guest Profile\"";

                # Window management
                "${mod}+v" = "floating toggle";
                "${mod}+m" = "exec pkill -USR1 swaylock 2>/dev/null; swaymsg exit";
                "${mod}+l" = "exec swaylock";

                "${mod}+Alt+l" = "exec systemctl suspend";

                # Noctalia
                "${mod}+r" = "exec noctalia msg panel-toggle launcher";
                "${shift}+s" = "exec noctalia msg screenshot-region";
                "${mod}+w" = "exec noctalia msg panel-toggle wallpaper";
                "${mod}+i" = "exec noctalia msg panel-toggle control-center";
                "${shift}+v" = "exec noctalia msg panel-toggle clipboard";
                "${mod}+n" = "exec rm -r ~/.local/state/noctalia/";

                # Focus
                "${mod}+Left" = "focus left";
                "${mod}+Right" = "focus right";
                "${mod}+Up" = "focus up";
                "${mod}+Down" = "focus down";

                # Move windows
                "${shift}+Left" = "move left";
                "${shift}+Right" = "move right";
                "${shift}+Up" = "move up";
                "${shift}+Down" = "move down";

                # Workspaces
                "${mod}+1" = "workspace number 1";
                "${mod}+2" = "workspace number 2";
                "${mod}+3" = "workspace number 3";
                "${mod}+4" = "workspace number 4";
                "${mod}+5" = "workspace number 5";
                "${mod}+6" = "workspace number 6";
                "${mod}+7" = "workspace number 7";
                "${mod}+8" = "workspace number 8";
                "${mod}+9" = "workspace number 9";

                # Move to workspaces
                "${shift}+1" = "move container to workspace number 1";
                "${shift}+2" = "move container to workspace number 2";
                "${shift}+3" = "move container to workspace number 3";
                "${shift}+4" = "move container to workspace number 4";
                "${shift}+5" = "move container to workspace number 5";
                "${shift}+6" = "move container to workspace number 6";
                "${shift}+7" = "move container to workspace number 7";
                "${shift}+8" = "move container to workspace number 8";
                "${shift}+9" = "move container to workspace number 9";

                # Audio
                "XF86AudioRaiseVolume" =
                    "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
                "XF86AudioLowerVolume" =
                    "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
                "XF86AudioMute" =
                    "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
                "XF86AudioMicMute" =
                    "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

                # Brightness
                "XF86MonBrightnessUp" =
                    "exec brightnessctl -e4 -n2 set 5%+";
                "XF86MonBrightnessDown" =
                    "exec brightnessctl -e4 -n2 set 5%-";

                # Media
                "XF86AudioNext" = "exec playerctl next";
                "XF86AudioPause" = "exec playerctl play-pause";
                "XF86AudioPlay" = "exec playerctl play-pause";
                "XF86AudioPrev" = "exec playerctl previous";

                # Mouse
                "${mod}+button4" = "workspace next";
                "${mod}+button5" = "workspace prev";
                "${mod}+button1" = "move";
                "${mod}+button3" = "resize";
                "button9" = "kill";
                "button8" = "workspace number 9";
            };

            # Startup
            startup = [
            { command = "noctalia-shell"; }
            ];

            # Default layout
            defaultWorkspace = "workspace number 1";
        };

        extraConfig = ''
            # ======================================
            # Catppuccin Mocha
            # ======================================

            set $mauve #cba6f7
            set $rosewater #f5e0dc
            set $base #1e1e2e
            set $text #cdd6f4

            # ======================================
            # SwayFX Visuals
            # ======================================

            # Rounded corners
            corner_radius 12

            # Blur
            blur enable
            blur_radius 8
            blur_passes 1

            # Shadows
            shadows enable
            shadow_blur_radius 20
            shadow_color #000000aa

            # Opacity
            default_dim_inactive 0.2

            # Borders
            client.focused $mauve $base $text $mauve $mauve
            client.unfocused $rosewater $base $text $rosewater $rosewater

            # ======================================
            # Layout
            # ======================================

            workspace_layout default

            # Suppress maximize events
            for_window [class=".*"] max_render_time off

            # ======================================
            # Window Rules
            # ======================================

            # Floating terminal / utility windows
            # Add specific rules here if needed.

            # ======================================
            # Gestures
            # ======================================

            # SwayFX gesture support depends on version.
            # Configure touchpad gestures separately if needed.
            '';
    };
}
