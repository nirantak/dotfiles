#!/bin/env bash
# Set up a new Termux environment on Android
set -xeuo pipefail
IFS=$'\n\t'

USER=$(whoami)

echo -e "\n \e[32m Updating System Packages \e[0m"
apt update && apt upgrade -y

echo -e "\n \e[32m Installing Packages \e[0m"
apt install -y build-essential man wget curl git nano vim zsh tmux htop less tree
apt install -y coreutils dnsutils net-tools ncurses-utils
apt install -y unzip gzip ffmpeg imagemagick atomicparsley
apt install -y python

pip install -U pip ipython httpie youtube-dl

echo -e "\n \e[32m Setting up Terminal \e[0m"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s /bin/zsh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

cp ~/dotfiles/shell/minimal.zshrc ~/.zshrc
touch ~/.hushlogin
termux-setup-storage

python --version
