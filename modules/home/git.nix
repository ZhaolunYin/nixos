{ pkgs, ... }:
{
    programs.git = {
        enable = true;
        settings = {
        	user = {
		        email = "yinzhaolun2012@gmail.com";
		        name = "Zhaolun Yin";
            };
            credential = {
                helper = "${pkgs.pass}/bin/pass";
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
