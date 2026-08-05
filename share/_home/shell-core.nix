{ pkgs, ... }:
{
    home.packages = with pkgs; [
        bat
        duf
        eza
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
                    "command-not-found"
                    "copyfile"
                ];
            };
            shellAliases = {
                ls = "eza --icons --group-directories-first";
                tree = "eza --icons --group-directories-first -T";
                cat = "bat -p --no-paging --theme=Catppuccin\\ Mocha";
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
                BROWSER = "firefox";
                # Hyprland
                XCURSOR_SIZE = "36";
                XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
                HYPRCURSOR_SIZE = "36";
                HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
                WLR_NO_HARDWARE_CURSORS = "1";
                LIBVA_DRIVER_NAME = "amd";
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
                # Theme
                BAT_THEME = "Catppuccin Mocha";
                FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
                FZF_CTRL_T_COMMAND = "fd --type f --hidden --follow --exclude .git";
                FZF_DEFAULT_OPTS = "--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 --color=selected-bg:#45475A --color=border:#6C7086,label:#CDD6F4";
                # Sudo prompt
                SUDO_PROMPT = "🔐 Password: ";
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
        fzf.enable = true;
        zoxide = {
            enable = true;
            enableZshIntegration = true;
        };
    };
}
