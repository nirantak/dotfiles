#!/bin/bash

echo -e "\n \e[32m Updating System Packages \e[0m"
sudo apt update
sudo apt dist-upgrade
sudo apt upgrade
sudo snap refresh

echo -e "\n \e[32m Updating NPM Packages \e[0m"
sudo npm update -g

echo -e "\n \e[32m Updating Python Packages \e[0m"
pip install --upgrade pip pipenv requests black flake8 rope numpy pandas matplotlib jupyterlab

echo -e "\n \e[32m Updating rbenv \e[0m"
cd "$(rbenv root)" && git pull
cd "$(rbenv root)"/plugins/ruby-build && git pull

echo -e "\n \e[32m Updating ZSH \e[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd "$ZSH"/custom/plugins/zsh-autosuggestions && git pull
cd "$ZSH"/custom/plugins/zsh-syntax-highlighting && git pull

echo -e "\n \e[32m Updating Pyenv \e[0m"
cd "$PYENV_ROOT" && git pull
