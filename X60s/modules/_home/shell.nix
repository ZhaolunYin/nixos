{ pkgs, ... }:
{
    home.packages = with pkgs; [
        bat
        duf
        (eza.overrideAttrs (old: {
            nativeBuildInputs = builtins.filter (x: x != pkgs.pandoc) old.nativeBuildInputs;

            outputs = [ "out" ];

            postInstall = ''
                installShellCompletion \
                --bash completions/bash/eza \
                --fish completions/fish/eza.fish \
                --zsh completions/zsh/_eza
            '';
        }))
        fd
        ripgrep
        trash-cli
    ];
    programs = {
        zsh = {
            enable = true;
            defaultKeymap = "emacs";
            enableAutosuggestions = true;
            enableCompletion = true;
            syntaxHighlighting = {
                enable = true;
                highlighters = [
                    "main"
                    "brackets"
                    "pattern"
                ];
                styles = {
                    "default" = "none";
                    "unknown-token" = "fg=red,bold";
                    "command" = "fg=green,bold";
                    "builtin" = "fg=cyan,bold";
                    "alias" = "fg=cyan,bold";
                    "function" = "fg=cyan,bold";
                };
            };
            shellAliases = {
                ls = "eza --group-directories-first";
                tree = "eza --group-directories-first -T";
                cat = "bat -p --no-paging";
                less = "bat --paging=always";
                df = "duf";
                top = "btop";
                cd = "z";
                ".." = "cd ..";
                "..." = "cd ../..";
                "...." = "cd ../../..";
                q = "exit";
                rm = ''printf "%s/n" "This command is disabled. Use trash-put or \\rm instead."'';
                sudo = "sudo ";
                nano = "nvim";
            };
            initExtra = ''
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
	    bindkey '^[[1;5D' backward-word
	    bindkey '^[[1;5C' forward-word
            '';

            sessionVariables = {
                EDITOR = "nvim";
                VISUAL = "nvim";
                GIT_EDITOR = "nvim";
                BROWSER = "falkon";

                LANG = "en_GB.UTF-8";
                LC_CTYPE = "en_GB.UTF-8";
                LC_NUMERIC = "en_GB.UTF-8";
                LC_TIME = "en_GB.UTF-8";
                LC_COLLATE = "en_GB.UTF-8";
                LC_MONETARY = "en_GB.UTF-8";
                LC_MESSAGES = "en_GB.UTF-8";
                LC_PAPER = "en_GB.UTF-8";
                LC_NAME = "en_GB.UTF-8";
                LC_ADDRESS = "en_GB.UTF-8";
                LC_TELEPHONE = "en_GB.UTF-8";
                LC_MEASUREMENT = "en_GB.UTF-8";
                LC_IDENTIFICATION = "en_GB.UTF-8";
                LC_ALL = "en_GB.UTF-8";

                FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
                FZF_CTRL_T_COMMAND = "fd --type f --hidden --follow --exclude .git";
            };
        };
        fzf.enable = true;
        zoxide = {
            enable = true;
            enableZshIntegration = true;
        };
    };
}
