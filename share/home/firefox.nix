{ pkgs, ... }:

{
    programs.firefox = {
        enable = true;

        profiles.default = {
            name = "default";
            isDefault = true;

            search = {
                force = true;
                default = "google";
            };

            bookmarks = {
                force = true;
                settings = [
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
                        ];
                    }
                ];
            };

            # Catppuccin theme
            settings = {
                "browser.newtabpage.enabled" = true;
                "browser.startup.homepage" = "";
                # Vertical tabs
                "sidebar.verticalTabs" = true;
                "sidebar.visibility" = "expand-on-hover";

                # Firefox Home
                "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
                "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
                "browser.newtabpage.activity-stream.showWeather" = false;
                "browser.newtabpage.activity-stream.feeds.topsites" = false;
            };

            extensions = {

            };
        };
    };
}
