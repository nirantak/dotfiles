# aliases

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

alias up="ping 8.8.8.8 -c 3"
alias ip-ext="dig +short myip.opendns.com @resolver1.opendns.com"
alias ip-int="ip a | grep -oP '(?<=inet )[^ ]*'"

alias note="vim +startinsert ~/Documents/notes.txt"
alias note-pd="vim +startinsert ~/Downloads/PD/Notes/notes.txt"
alias tmux="TERM=screen-256color-bce tmux -u"

alias b="browser-sync start --server --files='**/*'"
alias soundcloud="youtube-dl -i -c --audio-quality 0 --prefer-ffmpeg --embed-thumbnail --add-metadata --geo-bypass-country US"
alias ytmusic="youtube-dl -i -c --no-playlist -x --audio-format mp3 --audio-quality 0 --prefer-ffmpeg --embed-thumbnail --add-metadata"
alias ytd="youtube-dl"

alias ngrok="~/tools/ngrok"
alias jq="~/tools/jq-linux64"
alias jid="~/tools/jid_linux_amd64"
alias dman="~/dotfiles/scripts/dman.sh"
alias wrk="~/tools/wrk/wrk"
alias gotop="~/tools/gotop/gotop -p -c monokai"

alias dotfiles="cd ~/dotfiles && git status && code ."
alias freq_cmd="history | awk '{print $4}' | sort | uniq -c | sort -nr | head -10"
