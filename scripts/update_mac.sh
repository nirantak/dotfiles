#!/bin/bash
# Update all packages

echo -e "\n \x1B[32m Updating System Packages \x1B[0m"
brew update
brew upgrade
brew upgrade --cask
brew list --cask | grep -Ev "ngrok|font-victor-mono" | xargs brew upgrade --cask

echo -e "\n \x1B[32m Updating NPM Packages \x1B[0m"
sudo npm update -g

echo -e "\n \x1B[32m Updating Python Packages \x1B[0m"
pip install --upgrade pip wheel setuptools
pip install --upgrade black flake8 rope ipython httpie youtube-dl pre-commit

echo -e "\n \x1B[32m Updating Shell \x1B[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd $ZSH/custom/plugins/zsh-autosuggestions && git pull --ff-only
cd $ZSH/custom/plugins/zsh-syntax-highlighting && git pull --ff-only

echo -e "\n \x1B[32m Updating Pyenv \x1B[0m"
pyenv update
