# Author: Nirantak Raghav
# Link: github.com/nirantak/dotfiles

export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
export UPDATE_ZSH_DAYS=5
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
ZSH_DOTENV_PROMPT=false

plugins=(colorize command-not-found git python pip pyenv dotenv z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

HISTSIZE=100000
SAVEHIST="$HISTSIZE"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf*' 'fg=white,bold,bg=red')

export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";
export COLUMNS
export EDITOR="vim";
export VISUAL="vim";
export LESS="-iR"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 3)
export LESS_TERMCAP_md=$(tput bold; tput setaf 2)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export MANPAGER="less";
export PAGER="less";
export PYTHONIOENCODING="UTF-8";
export PYTHONUNBUFFERED=1
export PYENV_ROOT="$HOME/.pyenv"
export NODE_REPL_HISTORY_SIZE="100000";
export BAT_CONFIG_PATH="$HOME/dotfiles/shell/bat.conf"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$HOME/.local/bin:$PATH:/sbin:/usr/sbin"

alias r="reset"
alias l="pwd && ls"
alias ll="ls -ltrahF"
alias la="ls -a"
alias cp="cp -i"
alias rm="rm -i"
alias df="df -h"
alias free="free -m"
alias mkdir="mkdir -p"
alias clip="pbcopy"

alias path="echo $PATH | tr -s ':' '\n'"
alias del="sed -i 'N; $ !P; $ !D; $ d' ~/.zsh_history"
alias gs="git status"
alias gp="git pull --all --ff-only"
alias gb="git branch"
alias gd="git diff"

alias up="ping 8.8.8.8 -c 3"
alias ip-int="ipconfig getifaddr en0"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias data="networksetup -listnetworkserviceorder | grep 'Wi-Fi,' | cut -d' ' -f 5 | cut -d')' -f 1 | xargs -t vnstat -i"
alias flush_dns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

alias b="browser-sync start --server"
alias bd="browser-sync start --server --directory --files='**/*'"
alias rgf="rg --files | rg"
alias ytaud="youtube-dl -f bestaudio[ext!=webm] --extract-audio --audio-quality 0 --no-playlist --add-metadata --embed-thumbnail --prefer-ffmpeg"
alias ytvid="youtube-dl -f bestvideo[ext!=webm]+bestaudio[ext!=webm]/best[ext!=webm] --no-playlist --add-metadata --embed-thumbnail"
alias ytd="youtube-dl"
alias ytf="youtube-dl -F"

if [[ "$OSTYPE" == "linux"* ]]; then
  alias u="sudo apt update && sudo apt upgrade"
  alias rm="rm -I"
  alias clip="xsel --clipboard"
  alias ip-int="ip a | grep -oP '(?<=inet )[^ ]*'"
  alias data="ip a | grep -w inet | grep -v -w lo | awk '{print \$NF}' | xargs -t vnstat -i"
  alias flush_dns="sudo systemd-resolve --flush-caches"
fi

if [[ "$OSTYPE" == *"android"* ]]; then
  alias u="apt update && apt upgrade"
  alias d="cd ~/storage/shared/Download"
else
  eval "$(pyenv init -)"
fi
