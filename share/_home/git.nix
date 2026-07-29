{
    programs.git = {
        enable = true;
        settings = {
            user = {
                email = "yinzhaolun2012@gmail.com";
                name = "Zhaolun Yin";
            };
            credential = {
                helper = "cache --timeout=28800";
            };
            init = {
                defaultBranch = "main";
            };
            core = {
                ignorecase = false;
                editor = "nvim";
            };
            commit = {
                gpgsign = false;
            };
        };
    };
}
