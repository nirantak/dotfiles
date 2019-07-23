# aliases

# System
alias l="pwd && ls"
alias ll="ls -AlFh"
alias la="ls -a"
alias cp="cp -i"
alias rm="rm -i"
alias df="df -h"
alias free="free -m"
alias mkdir="mkdir -p"
alias clip="pbcopy"
alias path="echo $PATH | tr -s ':' '\n'"

# Networking
alias up="ping 8.8.8.8 -c 3"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-int="ipconfig getifaddr en0"

# Utilities
alias note="vim +startinsert ~/Documents/notes.md"
alias tmux="TERM=screen-256color-bce tmux -u"
alias dotfiles="cd ~/dotfiles && git status && code ."
alias freq_cmd="history | awk '{print $4}' | sort | uniq -c | sort -nr | head -10"

# Language Packages
alias b="browser-sync start --server"
alias bd="browser-sync start --server --directory --files='**/*'"
alias soundcloud="youtube-dl -i -c --audio-quality 0 --prefer-ffmpeg --embed-thumbnail --add-metadata --geo-bypass-country US"
alias ytmusic="youtube-dl -i -c --no-playlist -x --audio-format mp3 --audio-quality 0 --prefer-ffmpeg --embed-thumbnail --add-metadata"
alias ytd="youtube-dl"

# Docker
alias dcu="docker-compose up"
alias dcr="docker-compose run --rm"
alias dlf='docker logs -f'
alias dps="docker ps -a --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Command}}'"
alias dtop="docker stats --format 'table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.PIDs}}'"
alias dalias="__dalias"
alias dbash="__dbash"
alias dst="__dst"
alias dip="__dip"
alias dstop="__dstop"
alias drm="__drm"
alias drmi="__drmi"

# Linux Overrides
if [[ "$OSTYPE" == "linux"* ]]; then
    alias u="sudo apt update && sudo apt upgrade"
    alias rm="rm -I"
    alias clip="xsel --clipboard"
    alias ip-int="ip a | grep -oP '(?<=inet )[^ ]*'"
fi
