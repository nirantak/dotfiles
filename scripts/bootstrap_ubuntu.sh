#!/bin/bash
# Set up a new Ubuntu machine
set -xeuo pipefail
IFS=$'\n\t'

USER=$(whoami)

# Program versions for installation
PYTHON_VERSION=3.10.2
GO_VERSION=1.17.6
NODE_VERSION=17
RUBY_VERSION=3.1.0
BAT_VERSION=0.19.0
DOCKER_COMPOSE_VERSION=2.2.2

echo -e "\n \e[32m Updating System Packages \e[0m"
sudo apt update && sudo apt upgrade -y
sudo apt install -y snapd synaptic
sudo snap refresh

echo -e "\n \e[32m Installing Packages \e[0m"
sudo apt install -y make cmake build-essential ubuntu-restricted-extras ubuntu-restricted-addons libavcodec-extra
sudo apt install -y man wget curl git nano vim vim-gui-common zsh tmux htop less tree xclip xsel
sudo apt install -y apt-transport-https software-properties-common ca-certificates
sudo apt install -y coreutils dnsutils net-tools mosh openssh-client openssh-server
sudo apt install -y neofetch rar unrar zip unzip gzip bzip2 p7zip-full cabextract
sudo apt install -y terminator vlc imagemagick potrace ffmpeg pulseaudio paprefs cmus cmus-plugin-ffmpeg obs-studio
sudo apt install -y pandoc lynx krename cloc fzf ripgrep
sudo apt install -y clamav clamtk pass wireguard wireguard-tools wireguard-dkms
sudo apt install -y python-dev python3-pip python3-dev
sudo snap install insomnia spotify gimp
sudo snap install slack --classic
sudo apt install -y fonts-powerline fonts-firacode ttf-mscorefonts-installer command-not-found

curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo apt-key add - && \
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt install docker-ce
sudo usermod -aG docker ${USER}

sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Install Chrome, VSCode, docker-credential-helpers

echo -e "\n \e[32m Swappiness && inotify settings \e[0m"
cat /proc/sys/vm/swappiness && sudo bash -c "echo 'vm.swappiness = 20' >> /etc/sysctl.conf"
cat /proc/sys/vm/swappiness
cat /proc/sys/fs/inotify/max_user_watches && echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
cat /proc/sys/fs/inotify/max_user_watches

echo -e "\n \e[32m Setting up Terminal \e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

wget "https://github.com/sharkdp/bat/releases/download/v${BAT_VERSION}/bat_${BAT_VERSION}_amd64.deb" && \
sudo dpkg -i bat_${BAT_VERSION}_amd64.deb && \
rm bat_${BAT_VERSION}_amd64.deb

echo -e "\n \e[32m Installing pyenv \e[0m"
sudo apt install -y pkg-config autoconf bison libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev libyaml-dev libreadline6-dev
curl -L "https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer" | bash

echo -e "\n \e[32m Installing rbenv \e[0m"
curl -fsSL "https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer" | bash

echo -e "\n \e[32m Installing Golang \e[0m"
wget "https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && rm go${GO_VERSION}.linux-amd64.tar.gz

echo -e "\n \e[32m Installing NodeJS \e[0m"
curl -sL "https://deb.nodesource.com/setup_${NODE_VERSION}.x" | sudo -E bash -
sudo apt install -y nodejs nodejs-dev
sudo npm update -g
sudo npm install -g browser-sync speed-test diff-so-fancy eslint prettier

rbenv install ${RUBY_VERSION}
rbenv global ${RUBY_VERSION}
gem install bundler
gem update --system

pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}
pip install -U pip wheel setuptools
pip install -U black flake8 ipython pipx
for package in httpie youtube-dl pre-commit awscli;
  do pipx install $package;
done

ruby --version
node --version
go version
python --version
