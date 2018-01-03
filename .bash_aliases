# aliases

alias u='sudo apt update && sudo apt upgrade'
alias b='browser-sync start --server --files="**/*"'
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."
alias l='ls -la'
alias rm='rm -i'

# tmux
alias tmux="TERM=screen-256color-bce tmux"
alias tm="tmux new-session"
alias tl="tmux list-sessions"
alias ta="tmux attach -t"

# edit dotfiles
alias dotfiles="cd ~/dotfiles && git status"
alias editzshrc="vim ~/dotfiles/.zshrc"
alias editvimrc="vim ~/dotfiles/.vimrc"
alias edittmux="vim ~/dotfiles/.tmux.conf"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'
