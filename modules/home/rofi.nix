{ config, pkgs, ... }:

let
    inherit (config.lib.formats.rasi) mkLiteral;
in
{
    programs.rofi = {
        enable = true;

        location = "center";
        xoffset = 0;
        yoffset = 0;

        theme = {
            "*" = {
                selected-active-foreground  = mkLiteral "#1e1e2e";
                lightfg                     = mkLiteral "#cdd6f4";
                separatorcolor              = mkLiteral "#cdd6f4";
                urgent-foreground           = mkLiteral "#f38ba8";
                alternate-urgent-background = mkLiteral "#181825";
                lightbg                     = mkLiteral "#181825";
                background-color            = mkLiteral "transparent";
                border-color                = mkLiteral "#cdd6f4";
                normal-background           = mkLiteral "#1e1e2e";
                selected-urgent-background  = mkLiteral "#f38ba8";
                alternate-active-background = mkLiteral "#181825";
                spacing                     = 2;
                alternate-normal-foreground = mkLiteral "#cdd6f4";
                urgent-background           = mkLiteral "#1e1e2e";
                selected-normal-foreground  = mkLiteral "#181825";
                active-foreground           = mkLiteral "#89b4fa";
                background                  = mkLiteral "#1e1e2e";
                selected-active-background  = mkLiteral "#89b4fa";
                active-background           = mkLiteral "#1e1e2e";
                selected-normal-background  = mkLiteral "#b4befe";
                alternate-normal-background = mkLiteral "#181825";
                foreground                  = mkLiteral "#cdd6f4";
                selected-urgent-foreground  = mkLiteral "#1e1e2e";
                normal-foreground           = mkLiteral "#cdd6f4";
                alternate-urgent-foreground = mkLiteral "#f38ba8";
                alternate-active-foreground = mkLiteral "#89b4fa";
                highlight                   = mkLiteral "#cba6f7";
                search-highlight            = mkLiteral "#f38ba8";
            };

            element = {
                padding       = mkLiteral "1px";
                cursor        = mkLiteral "pointer";
                spacing       = mkLiteral "5px";
                border        = 0;
                border-radius = mkLiteral "1px";
            };

            "element normal.normal" = {
                background-color = mkLiteral "@normal-background";
                text-color       = mkLiteral "@normal-foreground";
            };

            "element normal.urgent" = {
                background-color = mkLiteral "@urgent-background";
                text-color       = mkLiteral "@urgent-foreground";
            };

            "element normal.active" = {
                background-color = mkLiteral "@active-background";
                text-color       = mkLiteral "@active-foreground";
            };

            "element selected.normal" = {
                background-color = mkLiteral "@selected-normal-background";
                text-color       = mkLiteral "@selected-normal-foreground";
            };

            "element selected.urgent" = {
                background-color = mkLiteral "@selected-urgent-background";
                text-color       = mkLiteral "@selected-urgent-foreground";
            };

            "element selected.active" = {
                background-color = mkLiteral "@selected-active-background";
                text-color       = mkLiteral "@selected-active-foreground";
            };

            "element alternate.normal" = {
                background-color = mkLiteral "@alternate-normal-background";
                text-color       = mkLiteral "@alternate-normal-foreground";
            };

            "element alternate.urgent" = {
                background-color = mkLiteral "@alternate-urgent-background";
                text-color       = mkLiteral "@alternate-urgent-foreground";
            };

            "element alternate.active" = {
                background-color = mkLiteral "@alternate-active-background";
                text-color       = mkLiteral "@alternate-active-foreground";
            };

            "element-text" = {
                background-color = mkLiteral "transparent";
                cursor           = mkLiteral "inherit";
                highlight        = mkLiteral "@search-highlight";
                text-color       = mkLiteral "inherit";
            };

            "element-icon" = {
                background-color = mkLiteral "transparent";
                size             = mkLiteral "1em";
                cursor           = mkLiteral "inherit";
                text-color       = mkLiteral "inherit";
            };

            window = {
                padding          = 5;
                background-color = mkLiteral "@background";
                border           = 2;
                border-radius    = mkLiteral "6px";
                border-color     = mkLiteral "@selected-normal-background";
            };

            mainbox = {
                padding = 0;
                border  = 0;
            };

            message = {
                padding      = mkLiteral "1px";
                border-color = mkLiteral "@separatorcolor";
                border       = mkLiteral "2px dash 0px 0px";
            };

            textbox = {
                text-color = mkLiteral "@foreground";
            };

            listview = {
                padding      = mkLiteral "2px 0px 0px";
                scrollbar    = true;
                border-color = mkLiteral "@separatorcolor";
                spacing      = mkLiteral "2px";
                lines        = 15;
                fixed-height = true;
                border       = mkLiteral "2px dash 0px 0px";
            };

            scrollbar = {
                width        = mkLiteral "4px";
                padding      = 0;
                handle-width = mkLiteral "8px";
                border       = 0;
                handle-color = mkLiteral "@highlight";
            };

            sidebar = {
                border-color = mkLiteral "@highlight";
                border       = mkLiteral "2px dash 0px 0px";
            };

            button = {
                cursor     = mkLiteral "pointer";
                spacing    = 0;
                text-color = mkLiteral "@normal-foreground";
            };

            "button selected" = {
                background-color = mkLiteral "@selected-normal-background";
                text-color       = mkLiteral "@selected-normal-foreground";
            };

            "num-filtered-rows" = {
                expand     = false;
                text-color = mkLiteral "Gray";
            };

            "num-rows" = {
                expand     = false;
                text-color = mkLiteral "Gray";
            };

            "textbox-num-sep" = {
                expand     = false;
                str        = "/";
                text-color = mkLiteral "Gray";
            };

            inputbar = {
                padding    = mkLiteral "1px";
                spacing    = mkLiteral "0px";
                text-color = mkLiteral "@normal-foreground";

                children = map mkLiteral [
                    "prompt"
                    "textbox-prompt-colon"
                    "entry"
                    "num-filtered-rows"
                    "textbox-num-sep"
                    "num-rows"
                    "case-indicator"
                ];
            };

            "case-indicator" = {
                spacing    = 0;
                text-color = mkLiteral "@normal-foreground";
            };

            entry = {
                text-color        = mkLiteral "@highlight";
                cursor            = mkLiteral "text";
                spacing           = 0;
                placeholder-color = mkLiteral "Gray";
                placeholder       = "Type to filter";
                border-radius     = mkLiteral "6px";
            };

            prompt = {
                spacing    = 0;
                text-color = mkLiteral "transparent";
            };

            "textbox-prompt-colon" = {
                margin     = mkLiteral "0px 0.3em 0em 0em";
                expand     = false;
                str        = ":";
                text-color = mkLiteral "inherit";
            };
        };
    };
}
