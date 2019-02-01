# aliases

# System
alias u="sudo apt update && sudo apt upgrade"
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

# Networking
alias up="ping 8.8.8.8 -c 3"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-int="ip a | grep -oP '(?<=inet )[^ ]*'"

# Utilities
alias note="vim +startinsert ~/Documents/notes.txt"
alias note-pd="vim +startinsert ~/Downloads/PD/Notes/notes.txt"
alias tmux="TERM=screen-256color-bce tmux -u"
alias dotfiles="cd ~/dotfiles && git status && code ."
alias freq_cmd="history | awk '{print $4}' | sort | uniq -c | sort -nr | head -10"

# Language Packages
alias b="browser-sync start --server --files='**/*'"
alias soundcloud="youtube-dl -i -c --audio-quality 0 --prefer-ffmpeg --embed-thumbnail --add-metadata --geo-bypass-country US"
alias ytmusic="youtube-dl -i -c --no-playlist -x --audio-format mp3 --audio-quality 0 --prefer-ffmpeg --embed-thumbnail --add-metadata"
alias ytd="youtube-dl"

# User tools
alias ngrok="~/tools/ngrok"
alias jq="~/tools/jq-linux64"
alias jid="~/tools/jid_linux_amd64"
alias dman="~/dotfiles/scripts/dman.sh"
alias wrk="~/tools/wrk/wrk"
alias gotop="~/tools/gotop/gotop -p -c monokai"

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
