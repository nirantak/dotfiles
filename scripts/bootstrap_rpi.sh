#!/bin/bash
# Set up a new Raspberry Pi
set -xeuo pipefail
IFS=$'\n\t'

USER=$(whoami)

# Program versions for installation
PYTHON_VERSION=3.9.4
NODE_VERSION=15
BAT_VERSION=0.18.0

echo -e "\n \e[32m Updating System Packages \e[0m"
sudo apt update && sudo apt upgrade -y

echo -e "\n \e[32m Installing Packages \e[0m"
sudo apt install -y make cmake build-essential man wget curl gzip coreutils
sudo apt install -y git nano vim vim-gui-common zsh tmux htop less tree xclip xsel
sudo apt install -y apt-transport-https software-properties-common ca-certificates
sudo apt install -y ufw dnsutils net-tools mosh openssh-client openssh-server
sudo apt install -y imagemagick atomicparsley ffmpeg cloc fzf ripgrep neofetch
sudo apt install -y fonts-powerline fonts-firacode command-not-found screen

echo -e "\n \e[32m Swappiness && inotify settings \e[0m"
cat /proc/sys/vm/swappiness && sudo bash -c "echo 'vm.swappiness = 20' >> /etc/sysctl.conf"
cat /proc/sys/fs/inotify/max_user_watches && echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
cat /proc/sys/fs/inotify/max_user_watches

echo -e "\n \e[32m Setting up Terminal \e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

wget "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_armhf.deb" && \
sudo dpkg -i bat_${BAT_VERSION}_armhf.deb && \
rm bat_${BAT_VERSION}_armhf.deb

echo -e "\n \e[32m Installing pyenv \e[0m"
sudo apt install -y pkg-config autoconf bison libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev libyaml-dev libreadline6-dev
curl -L "https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer" | bash

echo -e "\n \e[32m Installing NodeJS \e[0m"
curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | sudo -E bash -
sudo apt install -y nodejs
sudo npm update -g
sudo npm install -g browser-sync speed-test

pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}
pip install -U pip wheel setuptools
pip install -U ipython httpie

node --version
python --version

echo -e "\n \e[32m Security Settings \e[0m"
sudo ufw allow ssh
sudo ufw allow 80/tcp
sudo ufw allow 53/tcp
sudo ufw allow 53/udp
sudo ufw allow 67/tcp
sudo ufw allow 67/udp
sudo ufw allow 546:547/udp
sudo ufw enable
sudo ufw status
