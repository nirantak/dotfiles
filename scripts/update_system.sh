#!/bin/bash
# Update all packages

echo -e "\n \x1B[32m Updating Repos \x1B[0m"
cd ~/dotfiles && git pull --all --ff-only

echo -e "\n \x1B[32m Updating System Packages \x1B[0m"
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  brew update
  brew upgrade
  brew upgrade --cask
  brew list --cask | grep -Ev "font-victor-mono|font-source-code-pro" | xargs brew upgrade --cask
  brew autoremove && brew cleanup
elif [[ "$OSTYPE" == "linux-android" ]]; then
  # Termux
  apt update
  apt upgrade -y
  apt autoremove && apt autoclean
elif [[ "$OSTYPE" == "linux"* ]]; then
  # Linux
  LINUX_RELEASE=$(cat /etc/*-release)
  if [[ "$LINUX_RELEASE" == *"rhel"* ]]; then
    sudo yum update -y --skip-broken
    sudo yum upgrade -y --skip-broken
  else
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove && sudo apt autoclean
  fi

  if [[ "$LINUX_RELEASE" == *"ubuntu"* ]]; then
    sudo snap refresh
  fi
fi

echo -e "\n \x1B[32m Updating PIP and NPM Packages \x1B[0m"
pip install -U pip wheel setuptools ipython

if [[ "$OSTYPE" == "darwin"* ]]; then
  pip install -U black flake8
  pipx upgrade-all
  # npm update -g
elif [[ "$OSTYPE" == "linux-android" ]]; then
  pip install -U httpie youtube-dl
elif [[ "$OSTYPE" == "linux"* ]]; then
  if [[ "$LINUX_RELEASE" == *"ubuntu"* ]]; then
    pip install -U black flake8 pipx
    pipx upgrade-all
  fi
  if [[ "$LINUX_RELEASE" != *"rhel"* ]]; then
    sudo npm update -g
  fi
fi

echo -e "\n \x1B[32m Updating Shell \x1B[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd $ZSH/custom/plugins/zsh-autosuggestions && git pull --ff-only
cd $ZSH/custom/plugins/zsh-syntax-highlighting && git pull --ff-only

if [[ "$OSTYPE" != "linux-android" && "$LINUX_RELEASE" != *"rhel"* ]]; then
  echo -e "\n \x1B[32m Updating Pyenv \x1B[0m"
  pyenv update
fi

if [[ "$OSTYPE" == "linux"* && $(hostname) == "pie.run" ]]; then
  echo -e "\n \e[32m Updating PiHole \e[0m"
  pihole -up
  pihole -g
fi
