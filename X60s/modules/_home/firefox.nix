{ pkgs, inputs, ... }:
let
    unstable = import inputs.nixpkgs {
        inherit (pkgs.stdenv.hostPlatform) system;
        config = pkgs.config;
    };
in
{
    programs.firefox = {
        enable = true;
        package = unstable.firefox-esr;

        profiles.default = {
            name = "default";
            isDefault = true;

            search = {
                force = true;
                default = "google";
            };

            bookmarks = [
                {
                    name = "Frequent";
                    toolbar = true;
                    bookmarks = [
                        {
                            name = "ChatGPT";
                            url = "https://chatgpt.com";
                        }
                        {
                            name = "Claude";
                            url = "https://claude.ai";
                        }
                        {
                            name = "YouTube";
                            url = "https://youtube.com";
                        }
                        {
                            name = "Proton Mail";
                            url = "https://mail.proton.me";
                        }
                        {
                            name = "Reddit";
                            url = "https://reddit.com";
                        }
                        {
                            name = "Github";
                            url = "https://github.com";
                        }
                    ];
                }
            ];

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

                "dom.ipc.processCount" = 1;

                "browser.tabs.unloadOnLowMemory" = true;
                "browser.tabs.min_inactive_duration_before_unload" = 600000; # 10 minutes

                "browser.sessionhistory.max_entries" = 5;

                "network.prefetch-next" = false;
                "network.dns.disablePrefetch" = true;
                "network.predictor.enabled" = false;

                "extensions.pocket.enabled" = false;

                "toolkit.telemetry.enabled" = false;
                "toolkit.telemetry.unified" = false;
                "datareporting.healthreport.uploadEnabled" = false;

                "browser.newtabpage.activity-stream.showSponsored" = false;
                "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

                "image.cache.size" = 10485760; # 10 MiB

                "browser.cache.disk.enable" = false;

                "apt.shield.optoutstudies.enabled" = false;

                "app.normandy.enabled" = false;
                "app.normandy.api_url" = "";

                "network.http.speculative-parallel-limit" = 0;
            };
        };
    };
}
