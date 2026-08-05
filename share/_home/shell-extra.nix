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
            initContent = ''
            precmd() {
                printf '\e[6 q'
            }
            lazygit() {
                git add --all
                if [ $1 > /dev/null ]; then
                    git commit -m $1
                else
                    git commit -m 'changed stuff'
                fi
                git push
            }
            eval "$(zoxide init zsh)"
            '';
        };
        starship = {
            enable = true;
            enableZshIntegration = true;
            presets = [ "nerd-font-symbols" ];
            settings.add_newline = true;
        };
    };
}
