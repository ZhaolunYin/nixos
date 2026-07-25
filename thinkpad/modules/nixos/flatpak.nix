{
    services.flatpak = {
        enable = true;
        remotes = [
            { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
        ];
        packages = [
            "io.mrarm.mcpelauncher"
            "ro.go.hmlendea.DL-Desktop"
        ];

        overrides = {
            "io.mrarm.mcpelauncher".Environment = {
                SDL_GAMECONTROLLERCONFIG="03007bbfd620000020a7000010010000,PowerA Advantage Wired Controller for Nintendo Switch 2,a:b2,b:b1,x:b3,y:b0,back:b8,start:b9,leftstick:b10,rightstick:b11,leftshoulder:b4,rightshoulder:b5,lefttrigger:b6,righttrigger:b7,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,platform:Linux,";
            };
        };

        update.auto = {
            enable = true;
            onCalendar = "weekly"; # auto-update flatpaks
        };
    };
}
