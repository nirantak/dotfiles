# Profiling ZSH Performance
# zmodload zsh/zprof

# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# ZSH Settings
ZSH_THEME='powerlevel10k/powerlevel10k'
COMPLETION_WAITING_DOTS=true
HIST_STAMPS='dd.mm.yyyy'
DISABLE_MAGIC_FUNCTIONS=true
unsetopt correct_all
setopt correct
zstyle ':omz:update' mode disabled

# Note: zsh-syntax-highlighting must be the last plugin sourced
plugins=(command-not-found git z zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# User configuration
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf*' 'fg=white,bold,bg=red')

# History: http://zsh.sourceforge.net/Guide/zshguide02.html#l17
HISTSIZE=100000
SAVEHIST="$HISTSIZE"
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ `arch` == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

# Load shell aliases & functions
for file in ~/dotfiles/shell/{aliases.sh,functions.zsh,aliases.local.sh}; do
  [[ -f "$file" ]] && source "$file";
done;

eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Load custom extensions
extensions=(~/.p10k.zsh ~/.fzf.zsh ~/.iterm2_shell_integration.zsh $(brew --prefix)/etc/grc.zsh)
for file in ${extensions[@]}; do
  [[ -f "$file" ]] && source "$file";
done;
unset extensions file

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
# Profiling ZSH Performance
# zprof
