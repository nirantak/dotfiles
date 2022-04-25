#!/bin/bash
# Update all packages

echo -e "\n \x1B[32m Updating Repos \x1B[0m"
cd ~/dotfiles && git pull --all --ff-only

echo -e "\n \x1B[32m Updating System Packages \x1B[0m"
brew update
brew upgrade
brew upgrade --cask
brew list --cask | grep -Ev "font-victor-mono|font-source-code-pro" | xargs brew upgrade --cask

# echo -e "\n \x1B[32m Updating NPM Packages \x1B[0m"
# npm update -g

echo -e "\n \x1B[32m Updating Python Packages \x1B[0m"
pip install -U pip wheel setuptools
pip install -U black flake8 ipython
pipx upgrade-all

echo -e "\n \x1B[32m Updating Shell \x1B[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd $ZSH/custom/plugins/zsh-autosuggestions && git pull --ff-only
cd $ZSH/custom/plugins/zsh-syntax-highlighting && git pull --ff-only

echo -e "\n \x1B[32m Updating Pyenv \x1B[0m"
pyenv update
