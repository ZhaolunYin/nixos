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

            background = [
                {
                    monitor = "";
                    path = "$HOME/.config/background";
                    blur_passes = 0;
                    color = "rgb(1e1e2e)";
                }
            ];

            label = [
                # Layout
                {
                    monitor = "";
                    text = "Layout: $LAYOUT";
                    color = "rgb(cdd6f4)";
                    font_size = 25;
                    font_family = "JetBrainsMono Nerd Font";
                    position = "30, -30";
                    halign = "left";
                    valign = "top";
                }
                # Time
                {
                    monitor = "";
                    text = "$TIME";
                    color = "rgb(cdd6f4)";
                    font_size = 90;
                    font_family = "JetBrainsMono Nerd Font";
                    position = "-30, 0";
                    halign = "right";
                    valign = "top";
                }
                # Date
                {
                    monitor = "";
                    text = ''cmd[update:43200000] date +"%A, %d %B %Y"'';
                    color = "rgb(cdd6f4)";
                    font_size = 25;
                    font_family = "JetBrainsMono Nerd Font";
                    position = "-30, -150";
                    halign = "right";
                    valign = "top";
                }
            ];

            image = [
                {
                    monitor = "";
                    path = "/usr/share/pixmaps/archlinux-logo.png";
                    size = 200;
                    border_color = "rgb(cba6f7)";
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
                    outer_color = "rgb(cba6f7)";
                    inner_color = "rgb(313244)";
                    font_color = "rgb(cdd6f4)";
                    fade_on_empty = false;
                    placeholder_text = ''<span foreground="##cdd6f4"><i>󰌾 Logged in as </i><span foreground="##cba6f7">$USER</span></span>'';
                    hide_input = false;
                    check_color = "rgb(cba6f7)";
                    fail_color = "rgb(f38ba8)";
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
