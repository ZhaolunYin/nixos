{ pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        package = pkgs.firefox-esr;

        profiles.default = {
            id = 0;
            isDefault = true;

            settings = {
                "browser.newtabpage.enabled" = true;
                "browser.startup.homepage" = "";

                "sidebar.verticalTabs" = true;
                "sidebar.visibility" = "expand-on-hover";

                "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
                "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                "browser.newtabpage.activity-stream.showWeather" = false;
                "browser.newtabpage.activity-stream.feeds.topsites" = false;

                "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
                "ui.systemUsesDarkTheme" = 1;
                "browser.theme.toolbar-theme" = 0;
                "browser.theme.content-theme" = 0;
                "layout.css.prefers-color-scheme.content-override" = 0;
            };
        };
    };
}
