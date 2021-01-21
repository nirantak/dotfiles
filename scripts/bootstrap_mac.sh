#!/bin/bash
# Set up new MacOS machine
set -xeuo pipefail
IFS=$'\n\t'

USER=$(whoami)

# Program versions for installation
PYTHON_VERSION=3.9.1
RUBY_VERSION=3.0.0

echo -e "\n \e[32m Setting up Dev Env \e[0m"
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sudo chown -R $USER:$(id -gn $USER) ~/.config

echo -e "\n \e[32m Installing Packages \e[0m"
brew install curl wget git tree htop vim tmux zsh zsh-completions bat gnu-time gnu-sed gpgme grep
brew install python3 node go gcc pyenv rbenv nvm pandoc lynx imagemagick
brew install autossh vnstat openvpn coreutils hping wrk mtr telnet
brew install github/gh/gh chromedriver cloc diff-so-fancy jq fzf ripgrep

echo -e "\n \e[32m Installing Apps \e[0m"
brew install --cask google-chrome firefox spotify vlc notion rectangle
brew install --cask visual-studio-code iterm2 istat-menus ngrok docker
brew install --cask gimp insomnia beekeeper-studio mongodb-compass

echo -e "\n \e[32m Setting up Terminal \e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)
sudo chsh -s $(which zsh)

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

$(brew --prefix)/opt/fzf/install --all

brew untap caskroom/fonts
brew tap homebrew/cask-fonts
brew tap homebrew/services

brew install --cask font-fira-code font-source-code-pro font-hack-nerd-font font-victor-mono

rbenv install ${RUBY_VERSION}
rbenv global ${RUBY_VERSION}
gem install bundler
gem update --system

pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}

sudo npm install -g browser-sync speed-test tldr eslint prettier
pip install -U wheel pip pipenv black flake8 rope ipython httpie cookiecutter youtube-dl

ruby --version
node --version
go version
python --version
