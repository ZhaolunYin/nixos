{
    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = "hyprlock";
                before_sleep_cmd = "loginctl lock-session";
                after_sleep_cmd = "hyprctl dispatch dpms on";
            };

            listener = [
                {
                    timeout = 300;
                    on-timeout = "hyprctl eval \"hl.dispatch(hl.dsp.dpms({ action = 'off' }))\"";
                    on-resume = "hyprctl eval \"hl.dispatch(hl.dsp.dpms({ action = 'on' }))\"";
                }
                {
                    timeout = 180;
                    on-timeout = "loginctl lock-session";
                }
            ];
        };
    };
}
