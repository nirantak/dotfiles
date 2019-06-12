# aliases

# System
alias u="sudo apt update && sudo apt upgrade"
alias l="pwd && ls -a"
alias ll="ls -AlF"
alias la="ls -a"
alias cp="cp -i"
alias rm="rm -I"
alias df="df -h"
alias free="free -m"
alias mkdir="mkdir -p"
alias clip="xsel --clipboard"
alias path="echo $PATH | tr -s ':' '\n'"

# Networking
alias up="ping 8.8.8.8 -c 3"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-int="ip a | grep -oP '(?<=inet )[^ ]*'"

# Utilities
alias note="vim +startinsert ~/Documents/notes.md"
alias tmux="TERM=screen-256color-bce tmux -u"
alias dotfiles="cd ~/dotfiles && git status && code ."
alias freq_cmd="history | awk '{print $4}' | sort | uniq -c | sort -nr | head -10"

# Language Packages
alias b="browser-sync start --server --directory --files='**/*'"
alias soundcloud="youtube-dl -i -c --audio-quality 0 --prefer-ffmpeg --embed-thumbnail --add-metadata --geo-bypass-country US"
alias ytmusic="youtube-dl -i -c --no-playlist -x --audio-format mp3 --audio-quality 0 --prefer-ffmpeg --embed-thumbnail --add-metadata"
alias ytd="youtube-dl"

# User tools
alias dman="~/dotfiles/scripts/dman.sh"
alias ngrok="~/code/tools/ngrok"
alias jq="~/code/tools/jq-linux64"
alias jid="~/code/tools/jid_linux_amd64"
alias wrk="~/code/tools/wrk/wrk"
alias gotop="~/code/tools/gotop/gotop -pbs -c monokai"

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

# MacOS Overrides
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias rm="rm -i"
    alias clip="pbcopy"
    alias ip-int="ipconfig getifaddr en0"
    unalias ngrok
fi
