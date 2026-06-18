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
      "lfs \"customtransfer.xet\"" = {
        path = "git-xet";
        args = "transfer";
        concurrent = true;
      };
      "filter \"lfs\"" = {
        process = "git-lfs filter-process";
        required = true;
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
      };
    };
  };
}
