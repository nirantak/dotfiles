# Profiling ZSH Performance
# zmodload zsh/zprof

# Path to oh-my-zsh installation
export ZSH=~/.oh-my-zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZSH Settings
ZSH_THEME='powerlevel10k/powerlevel10k'
COMPLETION_WAITING_DOTS=true
HIST_STAMPS='dd.mm.yyyy'
ZSH_DOTENV_PROMPT=false
DISABLE_MAGIC_FUNCTIONS=true
unsetopt correct_all
setopt correct
zstyle ':omz:update' mode disabled

# Note: zsh-syntax-highlighting must be the last plugin sourced
plugins=(
  colorize
  command-not-found
  docker
  dotenv
  git
  python
  pip
  pyenv
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

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

# Load Shell aliases & functions
for file in ~/dotfiles/shell/{aliases.sh,functions.zsh,aliases.local.sh}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

eval "$(pyenv init --path)"
# eval "$(rbenv init -)"
eval "$(pyenv init -)"

if [[ "$OSTYPE" == "darwin"* ]]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Profiling ZSH Performance
# zprof
