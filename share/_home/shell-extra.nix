{
    programs = {
        zsh = {
            autosuggestion = {
                enable = true;
                highlight = "fg=#808080";
                strategy = [
                    "history"
                    "completion"
                ];
            };
        };
        starship = {
            enable = true;
            enableZshIntegration = true;
            presets = [ "nerd-font-symbols" ];
            settings.add_newline = true;
        };
    };
}
