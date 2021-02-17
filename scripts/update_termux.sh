#!/bin/env bash
# Update all packages

echo -e "\n \e[32m Updating System Packages \e[0m"
apt update
apt upgrade -y

echo -e "\n \e[32m Updating Python Packages \e[0m"
pip install --upgrade pip black ipython httpie youtube-dl

echo -e "\n \e[32m Updating Shell \e[0m"
env ZSH=$ZSH sh $ZSH/tools/upgrade.sh
cd $ZSH/custom/plugins/zsh-autosuggestions && git pull
cd $ZSH/custom/plugins/zsh-syntax-highlighting && git pull
