# Tree - display file hierarchy
function t() {
    tree -I '.git|.venv|venv|node_modules|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -ahC $2
}

# Cheatsheets https://github.com/chubin/cheat.sh
function cht() {
    curl https://cheat.sh/$1
}

# Markdown Viewer
function mdv () {
    pandoc $1 | lynx -stdin -underline_links -use_mouse
}

# Peek a file in the lower 3rd of tmux window
function peek () {
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
