static const struct arg args[] = {
    /* function          format              argument */
    { battery_perc,      "BAT %s | ",        "BAT0" },
    { wifi_essid,        "%s | ",            NULL },   /* or run_command for ethernet */
    { vol_perc,          "VOL %s | ",        "default" },
    { datetime,          "%Y-%m-%d | ",      NULL },
    { datetime,          "%H:%M",            NULL },
};
