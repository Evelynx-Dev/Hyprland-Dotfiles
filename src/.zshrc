# =========================================================
# ZSHRC — IRIS CONFIG
# Arch Linux • Wayland • Kitty • Oh My Zsh
# =========================================================

# ---------------------------------------------------------
# Guardas básicas
# ---------------------------------------------------------
[[ -z "$PS1" ]] && return

# ---------------------------------------------------------
# OH MY ZSH
# ---------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="jona"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ---------------------------------------------------------
# EDITORES
# ---------------------------------------------------------
export EDITOR="nano"
export VISUAL="nano"

# ---------------------------------------------------------
# HISTORIAL
# ---------------------------------------------------------
HISTFILE="$HOME/.Iris"
HISTSIZE=1000
SAVEHIST=1000

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# ---------------------------------------------------------
# OPCIONES DE SHELL
# ---------------------------------------------------------
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt INTERACTIVE_COMMENTS
setopt NO_BEEP
setopt PROMPT_SUBST

# Corrección ligera (no agresiva)
setopt CORRECT
unsetopt CORRECT_ALL

# ---------------------------------------------------------
# AUTOCOMPLETADO (OPTIMIZADO)
# ---------------------------------------------------------
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -C
else
  compinit
fi

zmodload zsh/complist

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''

# ---------------------------------------------------------
# ALIAS BÁSICOS
# ---------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cl='cd -'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'

alias df='df -h'
alias du='du -h'
alias free='free -h'

# ls moderno si existe
if command -v eza &>/dev/null; then
  alias ls='eza --group-directories-first'
  alias la='eza -la --group-directories-first --git'
  alias ll='eza -l --group-directories-first --git'
else
  alias ls='ls --color=auto --group-directories-first'
  alias la='ls -la --color=auto'
  alias ll='ls -l --color=auto'
fi

# ---------------------------------------------------------
# PACMAN / PARU
# ---------------------------------------------------------
if command -v paru &>/dev/null; then
  alias update='paru -Syu'
  alias install='paru -S'
  alias remove='paru -Rns'
  alias search='paru -Ss'
  alias cleanup='paru -Sc'
else
  alias update='sudo pacman -Syu'
  alias install='sudo pacman -S'
  alias remove='sudo pacman -Rns'
  alias search='pacman -Ss'
  alias cleanup='sudo pacman -Sc'
fi

# ---------------------------------------------------------
# WAYLAND CLIPBOARD
# ---------------------------------------------------------
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  alias pbcopy='wl-copy'
  alias pbpaste='wl-paste'
fi

# ---------------------------------------------------------
# FUNCIONES ÚTILES
# ---------------------------------------------------------
mkcd() {
  [[ -z "$1" ]] && return 1
  mkdir -p "$1" && cd "$1"
}

where() {
  command -v "$1" || echo "Not found"
}

histgrep() {
  grep -i "$1" "$HISTFILE" | tail -20
}

myip() {
  curl -s ifconfig.me && echo
}

# ---------------------------------------------------------
# AUTOSUGGESTIONS CONFIG
# ---------------------------------------------------------
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept

# ---------------------------------------------------------
# MENSAJE DE BIENVENIDA
# ---------------------------------------------------------
if [[ -o interactive ]]; then
  echo ""
  if command -v fastfetch &>/dev/null; then
    fastfetch --logo arch --logo-color-1 magenta --logo-color-2 cyan
  else
    echo " Arch Linux • ZSH $(zsh --version | awk '{print $2}')"
  fi
  echo ""
fi

# ---------------------------------------------------------
# CARGA LOCAL (OPCIONAL)
# ---------------------------------------------------------
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

