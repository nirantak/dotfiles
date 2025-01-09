# Author: Nirantak Raghav
# Single file config, to be put here: ~/.zshrc
# Link: https://github.com/nirantak/dotfiles

# ZSH Settings
export ZSH=~/.oh-my-zsh
ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"
DISABLE_MAGIC_FUNCTIONS=true
unsetopt correct_all
setopt correct
zstyle ':omz:update' mode disabled

# Note: zsh-syntax-highlighting must be the last plugin sourced
plugins=(command-not-found git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf*' 'fg=white,bold,bg=red')

# History: http://zsh.sourceforge.net/Guide/zshguide02.html#l17
HISTSIZE=100000
SAVEHIST="$HISTSIZE"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export COLUMNS
export HOSTNAME="${HOSTNAME:-$HOST}"

# Editor Settings
export EDITOR="vim"
export VISUAL="vim"

export LESS_TERMCAP_mb=$(tput bold; tput setaf 3) # start blink - yellow
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # start bold - green
export LESS_TERMCAP_me=$(tput sgr0) # turn off bold, blink and underline
# export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 6) # start standout - yellow on cyan
export LESS_TERMCAP_se=$(tput rmso; tput sgr0) # stop standout
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # start underline - white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0) # stop underline

export LESS="-FiR" # -e E --quit-at-eof, -F --quit-if-one-screen, -i --ignore-case, -r R --raw-control-chars, -X --no-init
export MANPAGER="less"
export PAGER="less"
export BAT_CONFIG_PATH="~/dotfiles/tools/bat.conf"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --ignore-file ~/dotfiles/git/global.gitignore"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Python https://docs.python.org/3/using/cmdline.html#environment-variables
export PYTHONIOENCODING="UTF-8"
export PYTHONUNBUFFERED=1
export PYENV_ROOT="$HOME/.pyenv"

# NodeJS https://nodejs.org/api/repl.html#repl_environment_variable_options
export NODE_REPL_HISTORY_SIZE="100000"
export NVM_DIR="$HOME/.nvm"

# For MacOS
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # allow fork() in python for OSX
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# System
alias l="pwd && ls"
alias ll="ls -ltrahF"
alias rm="rm -i"
alias df="df -h"
alias free="free -m"
alias mkdir="mkdir -p"
alias clip="pbcopy"
alias path='echo $PATH | tr -s ":" "\n"'
alias r="reset"
alias gs="git status"
alias gp="git pull --all --ff-only"
alias gb="git branch"
alias gd="git diff --diff-filter=d"
alias gds="git diff --staged --diff-filter=d"
alias gc="git checkout"
alias ss="ssh -At"

# Networking
alias up="ping 8.8.8.8 -c 3"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-int="ipconfig getifaddr en0"
alias data="networksetup -listnetworkserviceorder | grep 'Wi-Fi,' | cut -d' ' -f 5 | cut -d')' -f 1 | xargs -t vnstat -i"
alias flush_dns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

export GPG_TTY=$(tty)
export PATH="$HOME/.local/bin:/sbin:/usr/sbin:$PATH"

if [[ -d "$PYENV_ROOT" ]]; then
  export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

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
fi

# Load shell aliases & functions if they exist
for file in ~/dotfiles/shell/{aliases.sh,functions.zsh,aliases.local.sh}; do
  [[ -f "$file" ]] && source "$file";
done;

# Load custom extensions if they exist
extensions=(~/.fzf.zsh ~/dotfiles/tools/grc.zsh ~/code/dotfiles-ssh/functions.sh)
for file in ${extensions[@]}; do
  [[ -f "$file" ]] && source "$file";
done;
unset extensions file

PROMPT='%{$fg[cyan]%}%~ $(git_prompt_info)%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜) %{$reset_color%}'
