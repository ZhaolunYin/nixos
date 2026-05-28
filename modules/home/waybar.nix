{
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        settings = {
            mainBar = {
                layer = "top";
                position = "top";
                height = 46;

                modules-left = [
                    "hyprland/workspaces"
                    "idle_inhibitor"
                ];

                modules-center = [
                    "hyprland/window"
                    "clock"
                ];

                modules-right = [
                    "battery"
                    "temperature"
                    "backlight"
                    "pulseaudio"
                    "tray"
                ];

                idle_inhibitor = {
                    format = "{icon}";
                    format-icons = {
                        activated = " ";
                        deactivated = " ";
                    };
                };

                "hyprland/window" = {
                    format = "{title}";
                    max-length = 50;
                };

                clock = {
                    format = "{:%d - %H:%M}";
                    tooltip-format = "{:%A, %d %B %Y}";
                };

                battery = {
                    format = "  {capacity}%";
                    format-charging = " {capacity}%";
                    format-warning = "  {capacity}%";
                    states = {
                        warning = 30;
                        critical = 15;
                    };
                };

                temperature = {
                    thermal-zone = 0;
                    format = "  {temperatureC}°C";
                    critical-threshold = 80;
                };

                backlight = {
                    format = "󰃠  {percent}%";
                    tooltip = false;
                };

                pulseaudio = {
                    format = "{volume}% {icon} {format_source}";
                    format-bluetooth = "{volume}% {icon} {format_source}";
                    format-bluetooth-muted = " {icon} {format_source}";
                    format-muted = " {format_source}";
                    format-source = "{volume}% ";
                    format-source-muted = "";
                    format-icons = {
                        headphone = "";
                        phone = "";
                        portable = "";
                        car = "";
                        default = [ "" " " " " ];
                    };
                    on-click = "pavucontrol";
                };

                tray = {
                    spacing = 10;
                };
            };
        };
        style = ''
            @define-color rosewater #f5e0dc;
            @define-color mauve #cba6f7;
            @define-color yellow #f9e2af;
            @define-color teal #94e2d5;
            @define-color blue #89b4fa;
            @define-color text #cdd6f4;
            @define-color mantle #181825;
            @define-color crust #11111b;
            * {
                font-family: "JetBrainsMono Nerd Font";
                font-size: 14px;
                transition: all 0.2s ease;
            }

            /* BAR BASE */
            window#waybar {
                background: transparent;
                border-bottom: 2px solid transparent;
            }

            /* MODULE BASE */
            #window, #clock, #battery, #temperature, #backlight, #pulseaudio, #tray {
                padding: 6px 14px;
                margin: 6px 4px;
                border-radius: 10px;

                background: @mantle;
                color: @text;

                border: 2px solid @mauve;
            }

            /* WORKSPACES */
            #workspaces {
                margin-left: 8px;
            }

            #workspaces button {
                padding: 4px 12px;
                margin: 4px;
                border-radius: 10px;

                border: 2px solid @rosewater;
                color: @text;
                background: @mantle;
            }

            /* ACTIVE WORKSPACE (main flex) */
            #workspaces button.active {
                color: @mauve;
                border: 2px solid @mauve
            }


            /* CLOCK = center highlight */
            #window, #clock {
                font-weight: bold;
                color: @blue;
                background: @mantle;
            }

            /* AUDIO = pink accent */
            #pulseaudio {
                min-width: 80px;
            }

            /* IDLE INHIBITOR */
            #idle_inhibitor {
                padding: 6px 10px;
                margin: 4px;
                border-radius: 8px;

                color: @crust;
                background: @yellow;
            }

            #idle_inhibitor.activated {
                background: @teal;
            }
        '';
    };
}
