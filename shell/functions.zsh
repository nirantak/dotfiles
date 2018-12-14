# Tree - display file hierarchy
function t() {
    tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -ahC $2
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
