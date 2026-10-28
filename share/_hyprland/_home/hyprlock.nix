{ pkgs, ... }:
{
    programs.hyprlock = {
        enable = true;
        settings = {
            general = {
                hide_cursor = true;
            };

            auth = {
                fingerprint = {
                    enabled = true;
                    ready_message = "Scan fingerprint to unlock";
                    present_message = "Scanning...";
                };
            };
            animations = {
                enabled = true;
                bezier = [
                    "breathing, 0.4, 0.0, 0.2, 1.0"
                    "morning_mist, 0.5, 0.0, 0.0, 1.0"
                ];
                animation = [
                    "fade, 1, 10, breathing"
                    "inputField, 1, 5, morning_mist"
                    "inputFieldDots, 1, 4, breathing"
                ];
            };

            background = [
            {
                monitor = "";
                path = "screenshot";
                blur_passes = 2;
                noise = 0.01;
                contrast = 0.9;
                vibrancy = 0.25;
                vibrancy_darkness = 0.1;
                color = "rgba(1e1e2e80)";
            }
            ];

            label = [
            {
                monitor = "";
                text = "$TIME";
                color = "rgb(cdd6f4)";
                font_size = 90;
                font_family = "JetBrainsMono Nerd Font";
                position = "0, -250";
                halign = "center";
                valign = "top";
            }
# Date
            {
                monitor = "";
                text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
                color = "rgb(cdd6f4)";
                font_size = 25;
                font_family = "JetBrainsMono Nerd Font";
                position = "0, -400";
                halign = "center";
                valign = "top";
            }
            ];

            image = [
            {
                monitor = "";
                path = "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake.png";
                size = 200;
                border_size = 0;
                position = "0, 150";
                halign = "center";
                valign = "center";
            }
            ];

            "input-field" = [
            {
                monitor = "";
                size = "600, 120";
                outline_thickness = 8;
                dots_size = 0.3;
                dots_spacing = 0.3;
                dots_center = true;
                outer_color = "rgb(cba6f7) rgb(89b4fa) 45deg";
                inner_color = "rgb(313244)";
                font_color = "rgb(cdd6f4)";
                fade_on_empty = false;
                placeholder_text = ''<span foreground="##cdd6f4"><i>󰌾 Logged in as </i><span foreground="##cba6f7">$USER</span></span>'';
                hide_input = false;
                check_color = "rgb(cba6f7)";
                fail_color = "rgb(f38ba8) rgb(fab387) 40deg";
                fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
                capslock_color = "rgb(f9e2af)";
                position = "0, -94";
                halign = "center";
                valign = "center";
            }
            ];
        };
    };
}
