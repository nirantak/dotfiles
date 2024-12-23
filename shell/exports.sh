# Environment variables

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export COLUMNS
export HOSTNAME="${HOSTNAME:-$HOST}"

# Editor Settings
export EDITOR="vim"
export VISUAL="vim"

export LESS_TERMCAP_mb=$(tput bold; tput setaf 3) # start blink - yellow
export LESS_TERMCAP_md=$(tput bold; tput setaf 2) # start bold - green
export LESS_TERMCAP_me=$(tput sgr0) # turn off bold, blink and underline
# export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 6) # start standout - yellow on cyan
export LESS_TERMCAP_se=$(tput rmso; tput sgr0) # stop standout
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # start underline - white
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0) # stop underline

export LESS="-FiR" # -e E --quit-at-eof, -F --quit-if-one-screen, -i --ignore-case, -r R --raw-control-chars, -X --no-init
export MANPAGER="less"
export PAGER="less"
export BAT_CONFIG_PATH="$HOME/dotfiles/tools/bat.conf"
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --ignore-file ~/dotfiles/git/global.gitignore"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Python https://docs.python.org/3/using/cmdline.html#environment-variables
export PYTHONIOENCODING="UTF-8"
export PYTHONUNBUFFERED=1
export PYENV_ROOT="$HOME/.pyenv"

# NodeJS https://nodejs.org/api/repl.html#repl_environment_variable_options
export NODE_REPL_HISTORY_SIZE="100000"
export NVM_DIR="$HOME/.nvm"

# Go https://golang.org/doc/install/source#environment
export GOPATH="$HOME/.gopath"

# For MacOS
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # allow fork() in python for OSX
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export NO_CLI_METRICS=''

export PATH="$HOME/.local/bin:$GOPATH/bin:$HOME/.cargo/bin:$HOME/.poetry/bin:$PYENV_ROOT/bin:/usr/local/sbin:/usr/local/opt/mysql-client/bin:$PATH"
if [[ "$OSTYPE" == "linux"* ]]; then
  export PATH="$PATH:/snap/bin:/usr/local/go/bin"
else
  export DOCKER_DEFAULT_PLATFORM="linux/amd64"
fi

export GPG_TTY=$(tty)
