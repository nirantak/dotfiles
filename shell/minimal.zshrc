# Author: Nirantak Raghav
# Link: github.com/nirantak/dotfiles

export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
export UPDATE_ZSH_DAYS=5
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(colorize command-not-found git python pip z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

HISTSIZE=100000
SAVEHIST="$HISTSIZE"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf*' 'fg=white,bold,bg=red')

function t() {
    tree -I '.git|.venv|venv|node_modules|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -ahC $2
}
function cht() {
    curl https://cheat.sh/$1
}

export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";
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
export NODE_REPL_HISTORY_SIZE="100000";
export BAT_CONFIG_PATH="$HOME/dotfiles/shell/bat.conf"

alias h="cd /mnt/sdcard/Download"
alias u="sudo apt update && sudo apt upgrade"
alias b="browser-sync start --server --files='**/*'"
alias l="ls -lh"
alias ll="ls -AlF"
alias la="ls -a"
alias cp="cp -i"
alias rm="rm -I"
alias df="df -h"
alias free="free -m"
alias mkdir="mkdir -p"
alias cls="clear"
alias clip="xsel --clipboard"
alias path="echo $PATH | tr -s ':' '\n'"
alias up="ping 8.8.8.8 -c 3"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-int="ip a | grep -oP '(?<=inet )[^ ]*'"
alias freq_cmd="history | awk '{print $4}' | sort | uniq -c | sort -nr | head -10"
