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
zstyle ':completion:*' menu no
zstyle ':zfz-tab:completion:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':zfz-tab:completion:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
# alias ls='ls -la --color'
alias ls='eza -la --icons=always'
alias v='nvim'
alias c='clear'
alias g='git'
alias lg='lazygit'
alias zj='zellij'
alias fetch='fastfetch'

bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[4~"   end-of-line

# bun completions
[ -s "/home/erudhir/.bun/_bun" ] && source "/home/erudhir/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# run tmux when start
# if [ -z "$TMUX" ]
# then
#     tmux attach -t TMUX || tmux new -s TMUX
# fi


export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/.local/share/flatpak/exports/bin
export PATH=$PATH:/var/lib/flatpak/exports/bin
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/build/zig:$PATH
export EDITOR="nvim -u $HOME/.config/nvim/init.lua"
export VISUAL="nvim -u $HOME/.config/nvim/init.lua"
export MANPAGER="nvim -u $HOME/.config/nvim/init.lua +Man!"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

export _JAVA_AWT_WM_NONREPARENTING=1

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  export SDL_VIDEODRIVER=wayland
  export QT_QPA_PLATFORM=wayland
  if [ -z "$XDG_CURRENT_DESKTOP" ]; then
    export XDG_CURRENT_DESKTOP="sway"
  fi
  if [ -z "$XDG_SESSION_DESKTOP" ]; then
    export XDG_SESSION_DESKTOP="sway"
  fi
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
  export SDL_VIDEODRIVER=x11
  export QT_QPA_PLATFORM=xcb
  if [ -z "$XDG_CURRENT_DESKTOP" ] && [ -n "$DESKTOP_SESSION" ]; then
    export XDG_CURRENT_DESKTOP="$DESKTOP_SESSION"
  fi
  if [ -z "$XDG_SESSION_DESKTOP" ] && [ -n "$DESKTOP_SESSION" ]; then
    export XDG_SESSION_DESKTOP="$DESKTOP_SESSION"
  fi
else
  unset QT_QPA_PLATFORM
  unset SDL_VIDEODRIVER
fi

export NVM_DIR="$HOME/.nvm"
export NVM_USR_DIR="/usr/share/nvm/"
[ -s "$NVM_USR_DIR/init-nvm.sh" ] && \. "$NVM_USR_DIR/init-nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Shell integrations
source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
