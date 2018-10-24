# Author: Nirantak Raghav
# Link: github.com/nirantak/dotfiles

export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
export UPDATE_ZSH_DAYS=5
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd.mm.yyyy"
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt inc_append_history
setopt share_history

plugins=(git command-not-found colorize python pip zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf*' 'fg=white,bold,bg=red')

function t() {
	tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -ahC $2
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
export NODE_REPL_HISTORY="$HOME/.node_history";
export NODE_REPL_HISTORY_SIZE="32768";
export NODE_REPL_MODE="sloppy";
export PYTHONIOENCODING="UTF-8";

alias u="sudo apt update && sudo apt upgrade"
alias b="browser-sync start --server --files='**/*'"
alias h="cd /mnt/sdcard/Download"
alias l="ls -lh"
alias ll="ls -AlF"
alias la="ls -a"
alias rm="rm -I"
alias clip="xsel --clipboard"
alias up="ping 8.8.8.8 -c 3"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-int="ip a | grep -oP '(?<=inet )[^ ]*'"
alias path="echo $PATH | tr -s ':' '\n'"
