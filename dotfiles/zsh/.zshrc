# ========== PERFORMANCE OPTIMIZATION ==========
# Measure startup time (remove after setup)
# zmodload zsh/zprof

export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump"

# ========== OH-MY-ZSH CONFIGURATION ==========
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    git
    colored-man-pages
    command-not-found
    extract
    sudo
    web-search
    copyfile
    copypath
    dirhistory
    z
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ========== STARSHIP PROMPT ==========
# Install starship first: curl -sS https://starship.rs/install.sh | sh
if command -v starship > /dev/null; then
    eval "$(starship init zsh)"
else
    echo "⚠️  Starship not installed. Run: sudo pacman -S starship"
fi

export SUDO_PROMPT="🔐 Password please: "

# ========== EDITOR CONFIGURATION ==========
# Neovim as default editor
if command -v nvim > /dev/null; then
    export EDITOR='nvim'
    export VISUAL='nvim'
    
    # Git commit using nvim
    export GIT_EDITOR='nvim'

    alias nano='nvim'
    # Man pager using nvim
    export MANPAGER='nvim +Man!'
else
    echo "⚠️  Neovim not installed. Run: sudo pacman -S neovim"
    export EDITOR='vim'
    export VISUAL='vim'
fi

# ========== ENHANCED HISTORY SETTINGS ==========
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# ========== SHELL OPTIONS ==========
setopt AUTO_CD
unsetopt CORRECT
unsetopt CORRECT_ALL
setopt INTERACTIVE_COMMENTS
setopt AUTO_PUSHD           # Push directories to stack
setopt PUSHD_IGNORE_DUPS    # No duplicates in directory stack

# ========== MODERN ALIASES ==========
# Modern CLI tools
alias ls='eza --icons --group-directories-first'
alias tree='eza --icons --group-directories-first -T'

alias cat='bat -p --theme="OneHalfDark"'
alias less='bat --paging=always'
alias grep='rg --color=auto --engine=auto'
alias find='fd'  # If fd is installed
alias du='dust -X /tmp'
alias df='duf'
alias ps='procs'
alias top='btop'
alias speedtest='speedtest-tui'
alias f='fastfetch'
alias icat='kitten icat'

# Set C++ standard to 23
alias g++='g++ --std=c++23'


# cd aliases
eval "$(zoxide init zsh --cmd cd)"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias q='exit'

# Safety
alias rm='printf "%s\n" "This command is disabled. Use trash-put or \rm instead."'
alias sudo='sudo '

# Fix terminal keys
bindkey "\e[3~" delete-char
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[3;5~" kill-word
bindkey "\e[1;3D" backward-kill-word
bindkey "\e[1;3C" forward-kill-word

# History search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward

# ========== PLUGIN SOURCING ==========
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept
bindkey '^[^M' autosuggest-execute  # Alt+Enter to execute suggestion

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold

# Better completion
zstyle ':completion:*' menu no
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group ',' '.'

# ========== ENVIRONMENT VARIABLES ==========
# For bat theme
export BAT_THEME="OneHalfDark"

# Make eza respect LS_COLORS without paying the vivid startup cost every shell.
if command -v vivid >/dev/null 2>&1; then
    ls_colors_cache="${XDG_CACHE_HOME:-$HOME/.cache}/vivid/one-half-dark-ls_colors"
    if [[ ! -s "$ls_colors_cache" ]]; then
        mkdir -p "${ls_colors_cache:h}"
        vivid generate one-half-dark > "$ls_colors_cache" 2>/dev/null || true
    fi
    if [[ -s "$ls_colors_cache" ]]; then
        export LS_COLORS="$(<"$ls_colors_cache")"
    fi
fi

# Set default browser
export BROWSER=firefox-developer-edition

# Set language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Increase open files limit
ulimit -n 8192

# ========== FZF INTEGRATION ==========
if command -v fzf > /dev/null; then
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null || true
    source /usr/share/fzf/completion.zsh 2>/dev/null || true
    
    export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
    --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
    --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
    --color=selected-bg:#45475A \
    --color=border:#6C7086,label:#CDD6F4"

    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    # Use fzf for multi-result history suggestions instead of incremental search.
    bindkey '^R' fzf-history-widget

    source <(fzf --zsh)
fi

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

fastfetch
