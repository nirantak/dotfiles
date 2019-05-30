#!/bin/bash
# Update all packages

echo -e "\n \x1B[32m Updating System Packages \x1B[0m"
brew update
brew upgrade
brew cask upgrade

echo -e "\n \x1B[32m Updating NPM Packages \x1B[0m"
sudo npm update -g

echo -e "\n \x1B[32m Updating Python Packages \x1B[0m"
pip install --upgrade pip pipenv black flake8 rope ipython httpie requests

echo -e "\n \x1B[32m Updating Shell \x1B[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd $ZSH/custom/plugins/zsh-autosuggestions && git pull
cd $ZSH/custom/plugins/zsh-syntax-highlighting && git pull

echo -e "\n \x1B[32m Updating Pyenv \x1B[0m"
pyenv update