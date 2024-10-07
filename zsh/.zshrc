# Set the directory we want to store zinit and plugins

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d $ZINIT_HOME ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load init
source "${ZINIT_HOME}/zinit.zsh"

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux


# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
# zstyle ':completion:*' menu no
# zstyle ':zfz-tab:completion:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':zfz-tab:completion:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls -la --color'
alias v='nvim'
alias c='clear'
alias g='git'
alias lg='lazygit'
alias zl='zellij'


# bun completions
[ -s "/home/erudhir/.bun/_bun" ] && source "/home/erudhir/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
