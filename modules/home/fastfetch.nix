{
    programs.fastfetch = {
        enable = true;
        settings = {
            logo = {
                source = "nixos_small";
            };
            display = {
                separator = "  ";
                color = {
                    keys = "magenta";
                };
                size = {
                    ndigits = 0;
                    maxPrefix = "MB";
                };
                key = {
                    type = "icon";
                };
            };
            modules = [
                {
                    type = "title";
                    color = {
                        user = "green";
                        at = "red";
                        host = "blue";
                    };
                }
                "os"
                "kernel"
                "cpu"
                "memory"
                "packages"
                "localip"
                {
                    type = "colors";
                    key = "Colors";
                    block = {
                        range = [ 1 6 ];
                    };
                }
            ];
        };
    };
}
