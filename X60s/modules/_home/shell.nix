{ pkgs, ... }:
{
    home.packages = with pkgs; [
        bat
        duf
        fd
        ripgrep
        trash-cli
    ];
    programs = {
        zsh = {
            enable = true;
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
                ls = "eza --icons --group-directories-first";
                tree = "eza --icons --group-directories-first -T";
                cat = "bat -p --no-paging";
                less = "bat --paging=always";
                df = "duf";
                top = "btop";
                icat = "kitten icat";
                cd = "z";
                ".." = "cd ..";
                "..." = "cd ../..";
                "...." = "cd ../../..";
                q = "exit";
                rm = ''printf "%s/n" "This command is disabled. Use trash-put or \\rm instead."'';
                sudo = "sudo ";
                nano = "nvim";
            };
            sessionVariables = {
                # Shell
                EDITOR = "nvim";
                VISUAL = "nvim";
                GIT_EDITOR = "nvim";
                MANPAGER = "nvim +Man!";
                # Data dirs
                XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share";
                # Locale
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
                # Sudo prompt
                SUDO_PROMPT = "🔐 Password: ";
            };
        };
        fzf.enable = true;
        zoxide = {
            enable = true;
            enableZshIntegration = true;
        };
    };
}
