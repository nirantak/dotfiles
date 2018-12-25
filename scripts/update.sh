#!/bin/bash
# Update all packages

echo -e "\n \e[32m Updating System Packages \e[0m"
sudo apt update
sudo apt upgrade
sudo snap refresh

echo -e "\n \e[32m Updating NPM Packages \e[0m"
sudo npm update -g

echo -e "\n \e[32m Updating Python Packages \e[0m"
pip install --upgrade pip pipenv black flake8 rope ipython httpie requests youtube-dl

echo -e "\n \e[32m Updating rbenv \e[0m"
cd "$(rbenv root)" && git pull
cd "$(rbenv root)"/plugins/ruby-build && git pull

echo -e "\n \e[32m Updating Shell \e[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd $ZSH/custom/plugins/zsh-autosuggestions && git pull
cd $ZSH/custom/plugins/zsh-syntax-highlighting && git pull
cd $HOME/.fzf && git pull

echo -e "\n \e[32m Updating Pyenv \e[0m"
pyenv update
