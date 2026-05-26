{ pkgs, ... }:

{
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion = {
                enable = true;
                highlight = "fg=#808080";
                strategy = [ "history" "completion" ];
            };
            syntaxHighlighting = {
                enable = true;
                highlighters = [ "main" "brackets" "pattern" ];
                styles = {
                    "default" = "none";
                    "unknown-token" = "fg=red,bold";
                    "command" = "fg=green,bold";
                    "builtin" = "fg=cyan,bold";
                    "alias" = "fg=cyan,bold";
                    "function" = "fg=cyan,bold";
                };
            };
            history = {
                append = true;
                ignoreDups = true;
                ignoreAllDups = true;
                findNoDups = true;
                share = true;
                extended = true;
            };
            oh-my-zsh = {
                enable = true;
                plugins = [
                    "git"
                    "colored-man-pages"
                    "command-not-found"
                    "extract"
                    "sudo"
                    "web-search"
                    "copyfile"
                    "copypath"
                    "dirhistory"
                ];
            };
            shellAliases = {
                ls = "eza --icons --group-directories-first";
                tree = "eza --icons --group-directories-first -T";
                cat = "bat -p --theme=Catppuccin\ Mocha";
                less = "bat --paging=always";
                grep = "rg --color=auto --engine=auto";
                find = "fd";
                du = "dust -X /tmp -X /mnt";
                df = "duf";
                ps = "procs";
                top = "btop";
                f = "fastfetch";
                icat = "kitten icat";
                ".." = "cd ..";
                "..." = "cd ../..";
                "...." = "cd ../../..";
                q = "exit";
                rm = ''printf "%s/n" "This command is disabled. Use trash-put or \\rm instead."'';
                sudo = "sudo ";
                nano = "nvim";
            };
            sessionVariables = {
                EDITOR = "nvim";
                VISUAL = "nvim";
                GIT_EDITOR = "nvim";
                MANPAGER = "nvim +Man!";
                BROWSER = "firefox";
                LANG = "en_GB.UTF-8";
                LC_ALL = "en_GB.UTF-8";
                BAT_THEME = "Catppuccin Mocha";
                FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
                FZF_CTRL_T_COMMAND = "fd --type f --hidden --follow --exclude .git";
                FZF_DEFAULT_OPTS = ''
                    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
                    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
                    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
                    --color=selected-bg:#45475A \
                    --color=border:#6C7086,label:#CDD6F4
                '';
                SUDO_PROMPT = "🔐 Password: ";
            };
            initContent = ''
                fastfetch
            '';
        };
        starship = {
            enable = true;
            enableZshIntegration = true;
        };
        fzf = {
            enable = true;
            enableZshIntegration = true;
        };
        zoxide = {
            enable = true;
            enableZshIntegration = true;
        };
    };
}
