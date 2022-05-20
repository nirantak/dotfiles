# Tree - display file hierarchy
function t() {
  tree -I '.git|.venv|venv|node_modules|.DS_Store' --dirsfirst --filelimit 15 -L ${1:-3} -ahC $2
}

# Docker
function __dalias() {
  # Show all docker aliases
  alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort;
  alias | grep '__d' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/" | sed "s/['|\']//g" | sort;
}
function __dbash() {
  # Bash into running container
  docker exec -it $(docker ps -aqf "name=$1") bash;
}
function __dip() {
  # Inspect running container
  for container in "$@"; do
    docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" "${container}";
  done
}
function __dst() {
  # Show stats for running container
  if [ -z $1 ]
  then docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.PIDs}}';
  else docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.PIDs}}' | grep $1;
  fi
}
function __dstop() {
  # Stop running containers
  if [ $# -eq 0 ]
  then docker stop $(docker ps -aq --no-trunc);
  else
    for container in "$@"; do
      docker stop $(docker ps -aq --no-trunc | grep ${container});
    done
  fi
}
function __drm() {
  # Delete containers
  if [ $# -eq 0 ]
  then docker rm $(docker ps -aq --no-trunc);
  else
    for container in "$@"; do
      docker rm $(docker ps -aq --no-trunc | grep ${container});
    done
  fi
}
function __drmi() {
  # Delete images
  if [ $# -eq 0 ]
  then docker rmi $(docker images --filter 'dangling=true' -aq --no-trunc);
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

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

function load_nvm() {
  # NVM - Node Version Manager
  export NVM_DIR="$HOME/.nvm"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"
  else
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  fi
  # Autoload node version from .nvmrc
  autoload -U add-zsh-hook
  add-zsh-hook chpwd load_nvmrc
  load_nvmrc
}

# Show frequently used commands
function freq_cmd() {
  if [ -n "$1" ]
  then
    history | awk '{print $4}' | sort | uniq -c | sort -nr | head -n $1
  else
    history | awk '{print $4}' | sort | uniq -c | sort -nr | head
  fi
}

# Run latest ipython
function ipy() {
  global_python=`pyenv global`
  ~/.pyenv/versions/$global_python/bin/ipython
}

# Cleanup git repo
function git_clean() {
  git checkout master
  git pull --all --ff-only
  git branch -D `git branch | grep -v "\*\|master" | xargs`
  git gc
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
