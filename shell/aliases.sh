# aliases

# System
alias l="pwd && ls"
alias ll="ls -ltrahF"
alias rm="rm -i"
alias df="df -h"
alias free="free -m"
alias mkdir="mkdir -p"
alias clip="pbcopy"
alias path='echo $PATH | tr -s ":" "\n"'
alias sed="gsed"
alias r="reset"
alias gs="git status"
alias gp="git pull --all --ff-only"
alias gb="git branch"
alias gd="git diff --diff-filter=d"
alias gds="git diff --staged --diff-filter=d"
alias gc="git checkout"
alias ss="ssh -At"

# Networking
alias up="ping 1.1.1.1 -c 3"
alias digg="dig +noall +answer"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-int="ipconfig getifaddr en0"
alias data="networksetup -listnetworkserviceorder | grep 'Wi-Fi,' | cut -d' ' -f 5 | cut -d')' -f 1 | xargs -t vnstat -i"
alias flush_dns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias ports="sudo lsof -iTCP -sTCP:LISTEN -n -P"

# Utilities
alias note="vim +startinsert ~/Documents/notes.md"
alias dotfiles="cd ~/dotfiles && git status && code ."
alias del="sed -i 'N; $ !P; $ !D; $ d' ~/.zsh_history"  # Delete the last command and this command itself from history

# Tools
alias b="browser-sync start --server"
alias bd="browser-sync start --server --directory --files='**/*'"
alias rgf="rg --files | rg"
alias ytaud="youtube-dl -f bestaudio[ext!=webm] --extract-audio --audio-quality 0 --no-playlist --add-metadata --embed-thumbnail --prefer-ffmpeg"
alias ytvid="youtube-dl -f bestvideo[ext!=webm]+bestaudio[ext!=webm]/best[ext!=webm] --no-playlist --add-metadata --embed-thumbnail"
alias ytd="youtube-dl"
alias ytf="youtube-dl -F"

# Docker
alias dcr="docker run --rm -it --entrypoint bash"
alias dol="docker logs -f"
alias dps="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Command}}\t{{.Ports}}'"
alias dtop="docker stats --format 'table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.PIDs}}'"
alias dcl="docker compose logs -ft --tail=20"

# Linux Overrides
if [[ "$OSTYPE" == "linux"* ]]; then
  unalias sed
  alias u="sudo apt update && sudo apt upgrade"
  alias rm="rm -I"
  alias clip="xsel --clipboard"
  alias ip-int="ip a | grep -oP '(?<=inet )[^ ]*'"
  alias flush_dns="sudo systemd-resolve --flush-caches"
fi
