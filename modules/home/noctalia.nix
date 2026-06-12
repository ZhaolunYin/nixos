{
    systemd.user.services.noctalia-shell = {
        Service.Environment = [
            "NOCTALIA_PAM_SERVICE=noctalia-lock"
            "NOCTALIA_PAM_CONFIG=noctalia-lock"
        ];
    };
    home.sessionVariables = {
        NOCTALIA_PAM_SERVICE = "noctalia-lock";
        NOCTALIA_PAM_CONFIG = "noctalia-lock";
    };

    programs.noctalia = {
        enable = true;
        systemd.enable = true;

        settings = {
            shell = {
                font_family = "JetBrainsMono Nerd Font Mono";
                polkit_agent = true;
                telementry_enabled = false;
                screen_time_enabled = true;

                animation.speed = 0.75;

                corner_radius_scale = 1.15;

                shadow = {
                    direction = "down";
                    alpha = 0.65;
                };

                panel = {
                    background_blur = true;
                    transparency_mode = "glass";
                    borders = true;
                    shadow = true;
                    launcher_placement = "centered";
                    clipboard_placement = "centered";
                    control_center_placement = "attached";
                    wallpaper_placement = "attached";
                    session_placement = "attached";
                };
            };

            backdrop = {
                enabled = true;
                blur_intensity = 0.85;
                tint_intensity = 0.45;
            };

            theme = {
                mode = "dark";
                source = "builtin";
                builtin = "Catppuccin";
            };

            wallpaper = {
                enabled = true;
                fill_mode = "crop";
                transition = [
                    "fade"
                    "wipe"
                    "disc"
                    "stripes"
                    "zoom"
                    "honeycomb"
                ];
                transition_duration = 1500;
                edge_smoothness = 0.3;
                directory = "~/Pictures/Wallpapers";
                automation = {
                    automation = true;
                    interval_seconds = 120;
                };
                default = {
                    path = "~/Pictures/Wallpapers/nix-catppuccin.png";
                };
            };

            bar.default = {
                background_opacity = 0.58;
                radius = 14;
                margin_ends = 10;
                thickness = 32;
                widget_spacing = 12;
                shadow = true;
                start = [
                    "group:g2"
                    "workspaces"
                ];
                center = [
                    "group:g1"
                ];
                end = [
                    "group:g5"
                    "group:g3"
                    "group:g4"
                ];
                capsule_group = [
                    {
                        fill = "surface_variant";
                        id = "g1";
                        members = [ "active_window" "clock" "media" ];
                        opacity = 1.0;
                        padding = 6.0;
                    }

                    {
                        fill = "surface_variant";
                        id = "g2";
                        members = [ "caffeine" "wallpaper" ];
                        opacity = 1.0;
                        padding = 6.0;
                    }

                    {
                        fill = "surface_variant";
                        id = "g3";
                        members = [ "volume" "brightness" ];
                        opacity = 1.0;
                        padding = 6.0;
                    }

                    {
                        fill = "surface_variant";
                        id = "g4";
                        members = [ "control-center" "notifications" ];
                        opacity = 1.0;
                        padding = 6.0;
                    }

                    {
                        fill = "surface_variant";
                        id = "g5";
                        members = [ "battery" "network" ];
                        opacity = 1.0;
                        padding = 6.0;
                    }
                ];
            };

            control_center.shortcuts = [
                "wifi"
                "bluetooth"
            ];

            desktop_widgets = {
                schema_version = 1;
                widget_order = [
                    "desktop-widget-1"
                    "desktop-widget-2" 
                    "desktop-widget-3"
                ];

                grid = {
                    cell_size = 16;
                    major_interval = 4;
                    visible = true;
                };

                widget.desktop-widget-1 = {
                    cx = 322.0;
                    cy = 290.5;
                    output = "";
                    rotation = 0.0;
                    scale = 1.0;
                    type = "clock";
                    settings = {
                        background = false;
                    };
                };

                widget.desktop-widget-2 = {
                    cx = 1232.0;
                    cy = 900.0;
                    output = "";
                    rotation = 0.0;
                    scale = 1.6000000238418579;
                    type = "audio_visualizer";
                    settings = {
                        aspect_ratio = 2.5;
                        bands = 32;
                        show_when_idle = true;
                        background = false;
                    };
                };

                widget.desktop-widget-3 = {
                    cx = 1252.0;
                    cy = 321.5;
                    output = "";
                    rotation = 0.0;
                    scale = 1.0;
                    type = "sysmon";
                    background = false;
                };
            };

            location = {
                auto_locate = true;
            };

            lockscreen = {
                blurred_desktop = false;
            };

            widget = {
                workspaces = {
                    minimal = true;
                };
            };

            notification.background_opacity = 0.78;
            osd.background_opacity = 0.78;
        };
    };
}
