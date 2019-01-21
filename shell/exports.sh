# Environment variables

export LANG="en_US.UTF-8";
export LC_ALL="en_US.UTF-8";

# Editor Settings
export EDITOR="vim";
export VISUAL="vim";

export LESS="-iR"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 3) # start blink - yellow
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # start bold - green
export LESS_TERMCAP_me=$(tput sgr0) # turn off bold, blink and underline
# export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 6) # start standout - yellow on cyan
export LESS_TERMCAP_se=$(tput rmso; tput sgr0) # stop standout
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # start underline - white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0) # stop underline
export MANPAGER="less";
export PAGER="less";
export BAT_CONFIG_PATH="$HOME/dotfiles/shell/bat.conf"

# Python https://docs.python.org/3/using/cmdline.html#environment-variables
export PYTHONIOENCODING="UTF-8";
export PYTHONUNBUFFERED=1
export PYENV_ROOT="$HOME/.pyenv";

# NodeJS https://nodejs.org/api/repl.html#repl_environment_variable_options
export NODE_REPL_HISTORY_SIZE="100000";
export NVM_DIR="$HOME/.nvm"

# Go https://golang.org/doc/install/source#environment
export GOPATH="$HOME/code/go"
export GOOS="linux"
export GOARCH="amd64"

export PATH="/snap/bin:$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.fzf/bin:$HOME/.pyenv/bin:/usr/local/go/bin:$HOME/.rbenv/bin"

export GPG_TTY=$(tty)
