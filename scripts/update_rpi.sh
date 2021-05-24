#!/bin/env bash
# Update all packages

echo -e "\n \e[32m Updating Repos \e[0m"
cd ~/dotfiles && git pull --all --ff-only

echo -e "\n \e[32m Updating System Packages \e[0m"
sudo apt update
sudo apt upgrade -y

echo -e "\n \e[32m Updating Python Packages \e[0m"
pip install -U pip wheel setuptools
pip install -U ipython httpie youtube-dl

echo -e "\n \e[32m Updating NPM Packages \e[0m"
sudo npm update -g

echo -e "\n \e[32m Updating Shell \e[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd $ZSH/custom/plugins/zsh-autosuggestions && git pull --ff-only
cd $ZSH/custom/plugins/zsh-syntax-highlighting && git pull --ff-only

echo -e "\n \e[32m Updating Pyenv \e[0m"
pyenv update

echo -e "\n \e[32m Updating PiHole \e[0m"
pihole -up
pihole -g
