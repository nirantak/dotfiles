# Profiling ZSH Performance
# zmodload zsh/zprof

# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

#Theme
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv nvm pyenv virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=''
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
POWERLEVEL9K_PYTHON_ICON='\u2695' # get_icon_names
POWERLEVEL9K_RUBY_ICON='\xF0\x9F\x92\x8E'
POWERLEVEL9K_SERVER_ICON='\xF0\x9F\x96\xA5'
POWERLEVEL9K_HOME_ICON='\xF0\x9F\x97\x80'
POWERLEVEL9K_FOLDER_ICON='\xF0\x9F\x96\xBF'
POWERLEVEL9K_DISK_ICON='\xF0\x9F\x92\xBE'
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='233' # spectrum_ls
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='075'
POWERLEVEL9K_DIR_HOME_BACKGROUND='013'
POWERLEVEL9K_PYTHON_BACKGROUND='071'
POWERLEVEL9K_NVM_BACKGROUND='002'
POWERLEVEL9K_PYENV_BACKGROUND='002'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='005'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='black'

export UPDATE_ZSH_DAYS=5
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt inc_append_history # To save every command before it is executed
setopt share_history # share history between open terminals

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Note that zsh-syntax-highlighting must be the last plugin sourced.
plugins=(git command-not-found colorize python pip zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf*' 'fg=white,bold,bg=red')

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/home/nirantak/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# Tree - display file hierarchy
function t() {
	tree -I '.git|node_modules|bower_components|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -ahC $2
}

# extract any time of compressed file
function extract() {
	echo Extracting $1 ...
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1  ;;
			*.tar.gz)    tar xzf $1  ;;
			*.bz2)       bunzip2 $1  ;;
			*.rar)       rar x $1    ;;
			*.gz)        gunzip $1   ;;
			*.tar)       tar xf $1   ;;
			*.tbz2)      tar xjf $1  ;;
			*.tgz)       tar xzf $1  ;;
			*.zip)       unzip $1   ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1  ;;
			*)        echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# # Autoload node version from .nvmrc
# autoload -U add-zsh-hook
# load-nvmrc() {
#   local node_version="$(nvm version)"
#   local nvmrc_path="$(nvm_find_nvmrc)"

#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#       nvm use
#     fi
#   elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# eval "$(direnv hook zsh)"
eval "$(rbenv init -)"
eval "$(pyenv init -)"

# Load Shell aliases
[ -r ~/.aliases ] && [ -f ~/.aliases ] && source ~/.aliases;

# Profiling ZSH Performance
# zprof
