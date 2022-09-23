# Tree - display file hierarchy
function t() {
  tree -I '.git|.venv|venv|node_modules|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -ahC $2
}

# Docker
function dalias() {
  # Show all docker aliases
  alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort;
  alias | grep '__d' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort;
}
function dbash() {
  # Bash into running container
  docker exec -it $(docker ps -aqf "name=$1") bash;
}
function dip() {
  # Inspect running container
  for container in "$@"; do
    docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" "${container}";
  done
}
function dst() {
  # Show stats for running container
  if [[ -z $1 ]]; then
    docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.PIDs}}';
  else
    docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.PIDs}}' | grep $1;
  fi
}
function dstop() {
  # Stop running containers
  if [[ $# -eq 0 ]]; then
    docker stop $(docker ps -aq --no-trunc);
  else
    for container in "$@"; do
      docker stop $(docker ps -aq --no-trunc | grep ${container});
    done
  fi
}
function drm() {
  # Delete containers
  if [[ $# -eq 0 ]]; then
    docker rm $(docker ps -aq --no-trunc);
  else
    for container in "$@"; do
      docker rm $(docker ps -aq --no-trunc | grep ${container});
    done
  fi
}
function drmi() {
  # Delete images
  if [[ $# -eq 0 ]]; then
    docker rmi $(docker images --filter 'dangling=true' -aq --no-trunc);
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
function md() {
  pandoc $1 | lynx -stdin -underline_links -use_mouse
}

# Peek a file in the lower 3rd of tmux window
function peek() {
  tmux split-window -p 33 "$EDITOR" "$@"
}

function load_nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [[ -n "$nvmrc_path" ]]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [[ "$nvmrc_node_version" = "N/A" ]]; then
      nvm install
    elif [[ "$nvmrc_node_version" != "$node_version" ]]; then
      nvm use
    fi
  elif [[ "$node_version" != "$(nvm version default)" ]]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

function load_nvm() {
  # NVM - Node Version Manager
  export NVM_DIR="$HOME/.nvm"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    for file in $(brew --prefix)/opt/nvm/{nvm.sh,etc/bash_completion.d/nvm}; do
      [[ -f "$file" ]] && source "$file"
    done
  else
    for file in $NVM_DIR/{nvm.sh,bash_completion}; do
      [[ -f "$file" ]] && source "$file"
    done
  fi
  # Autoload node version from .nvmrc
  autoload -U add-zsh-hook
  add-zsh-hook chpwd load_nvmrc
  load_nvmrc
}

# Show frequently used commands
function freq_cmd() {
  if [[ -n "$1" ]]; then
    history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n $1
  else
    history | awk '{print $4}' | sort | uniq -c | sort -nr | head
  fi
}

# Go to project root
function git_root() {
  cd "$(git rev-parse --show-toplevel)"
}

# Find when arg $1 was introduced in file $2
function git_search() {
  git log -S "$1" --source --all $2
}

# Shorten URLs using ray.run
function shorten() {
  (cd ~/code/nirantak/ray.run/ && npm run shorten $1 $2)
}

# Python virtualenv
function venv() {
  venv_path="$HOME/.virtualenvs"
  venv_name=$(basename `pwd`)

  if [[ ! -f "$venv_path/$venv_name/bin/activate" ]]; then
    echo -e "\x1B[33mCreating venv: $venv_path/$venv_name \x1B[0m\n"
    python3 -m venv --upgrade-deps "$venv_path/$venv_name"
    echo -e ""
  fi

  echo -e "\x1B[32mActivating venv: $venv_path/$venv_name \x1B[0m"
  source "$venv_path/$venv_name/bin/activate"
}

# Tmux
function mux() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: mux <hostname> [tmux_options | default -CC]"
    return 1
  fi
  ssh $1 -t "tmux ${2:--CC} new -A -s nirantak"
}

# Refresh extensions
function refresh_ext() {
  curl -sL https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
  curl -sL https://iterm2.com/shell_integration/bash -o ~/.iterm2_shell_integration.bash
  curl -sL https://raw.github.com/arcticicestudio/nord-dircolors/develop/src/dir_colors -o ~/.dir_colors

  # Remove comments to reduce file size for SCP
  sed -i'' '/^[[:space:]]*#/d; /#$/d' ~/.iterm2_shell_integration.bash

  cp -fv "$(brew --prefix)/etc/grc.zsh" ~/dotfiles/tools/grc.zsh

  if [[ "$OSTYPE" == "darwin"* ]]; then
    gdircolors -b ~/.dir_colors
  else
    dircolors -b ~/.dir_colors
  fi
}

# SCP shell config and the SSH
function s() {
  host="$1"
  echo "Uploading custom config to $host"
  cat ~/dotfiles/shell/{.bashrc,aliases.local.sh} ~/.iterm2_shell_integration.bash > ~/custom_shell_for_${USER}.bashrc
  scp -q -o LogLevel=QUIET ~/custom_shell_for_${USER}.bashrc $host:~/.bashrc
  echo "SSHing into $host"
  ssh -At $host
}

# Display all available colors upto $1 or 255
function colors () {
  num=${1:-255}
  for n in $(seq 0 $num); do
    printf '\e[48;5;%dm %03d ' $n $n
  done
  printf '\e[0m \n'
}
