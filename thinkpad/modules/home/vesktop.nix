{
    programs.vesktop = {
        enable = true;
        settings = {
            discordBranch = "stable";
            hardwareAcceleration = true;
            minimizeToTray = true;
            plugins = {
                MessageLogger.enabled = true;
                FakeNitro.enabled = true;
            };
        };
    };
}
