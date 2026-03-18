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
elif [[ "$OSTYPE" == "linux"* ]]; then
  # Linux
  LINUX_RELEASE=$(cat /etc/*-release)
  if [[ "$LINUX_RELEASE" == *"rhel"* || "$LINUX_RELEASE" == *"Mariner"* ]]; then
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

echo -e "\n \x1B[32m Updating Language Packages \x1B[0m"
pipx upgrade-all

echo -e "\n \x1B[32m Updating Shell \x1B[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd $ZSH/custom/plugins/zsh-autosuggestions && git pull --ff-only
cd $ZSH/custom/plugins/zsh-syntax-highlighting && git pull --ff-only

if [[ "$OSTYPE" == "linux"* && $(hostname) == "pie.run" ]]; then
  echo -e "\n \e[32m Updating PiHole \e[0m"
  pihole -up
  pihole -g
fi
