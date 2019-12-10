# Tree - display file hierarchy
function t() {
    tree -I '.git|.venv|venv|node_modules|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -ahC $2
}

# Docker
function __dalias() {
    # Show all docker aliases
    alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort;
    alias | grep '__d' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort;
}
function __dbash() {
    # Bash into running container
    docker exec -it $(docker ps -aqf "name=$1") bash;
}
function __dip() {
    for container in "$@"; do
        docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" "${container}";
    done
}
function __dst() {
    if [ -z $1 ]
    then docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.PIDs}}';
    else docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.PIDs}}' | grep $1;
    fi
}
function __dstop() {
    if [ $# -eq 0 ]
    then docker stop $(docker ps -aq --no-trunc);
    else
        for container in "$@"; do
            docker stop $(docker ps -aq --no-trunc | grep ${container});
        done
    fi
}
function __drm() {
    if [ $# -eq 0 ]
    then docker rm $(docker ps -aq --no-trunc);
    else
        for container in "$@"; do
            docker rm $(docker ps -aq --no-trunc | grep ${container});
        done
    fi
}
function __drmi() {
    if [ $# -eq 0 ]
    then docker rmi $(docker images --filter 'dangling=true' -aq --no-trunc);
    else
        for container in "$@"; do
            docker rmi $(docker images --filter 'dangling=true' -aq --no-trunc | grep ${container});
        done
    fi
}

# Cheatsheets https://github.com/chubin/cheat.sh
function cht() {
    curl https://cheat.sh/$1
}

# Markdown Viewer
function mdv() {
    pandoc $1 | lynx -stdin -underline_links -use_mouse
}

# Peek a file in the lower 3rd of tmux window
function peek() {
    tmux split-window -p 33 "$EDITOR" "$@"
}

# Extract any type of compressed file
function extract() {
    echo "Extracting $1 ..."
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1    ;;
            *.tar.gz)    tar xzf $1    ;;
            *.bz2)       bunzip2 $1    ;;
            *.rar)       rar x $1      ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1     ;;
            *.tbz2)      tar xjf $1    ;;
            *.tgz)       tar xzf $1    ;;
            *.zip)       unzip $1      ;;
            *.Z)         uncompress $1 ;;
            *.7z)        7z x $1       ;;
            *)        echo "$1 cannot be extracted via extract()" ;;
        esac
    else
        echo "$1 is not a valid file"
    fi
}

function load_nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
        nvm install
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
        nvm use
        fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}

function load_nvm() {
    # NVM - Node Version Manager
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    # Autoload node version from .nvmrc
    autoload -U add-zsh-hook
    add-zsh-hook chpwd load_nvmrc
    load_nvmrc
}

# Show frequently used commands
function freq_cmd() {
    if [ -n "$1" ]
    then
        history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n $1
    else
        history | awk '{print $4}' | sort | uniq -c | sort -nr | head
    fi
}
