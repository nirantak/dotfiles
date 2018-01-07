# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

ZSH_THEME="agnoster"
# How often to auto-update (in days).
export UPDATE_ZSH_DAYS=5
# Enable command auto-correction.
ENABLE_CORRECTION="true"
# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt inc_append_history # To save every command before it is executed
setopt share_history # share history between open terminals

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git command-not-found colorize python pip tmux)

source $ZSH/oh-my-zsh.sh

# User configuration

# Load the shell dotfiles, and then some:
for file in ~/.{exports,aliases}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

eval "$(direnv hook zsh)"
