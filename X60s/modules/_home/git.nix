{
    programs.git = {
        enable = true;

        userName = "Zhaolun Yin (alt)";
        userEmail = "yinzhaolun2012@gmail.com";

        extraConfig = {
            credential.helper = "cache --timeout=28800";

            init.defaultBranch = "main";
            pull.rebase = true;
            rebase.autoStash = true;

            core = {
                ignorecase = false;
                editor = "nvim";
            };

            commit.gpgsign = false;
        };
    };
}
