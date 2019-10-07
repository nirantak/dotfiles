#!/bin/bash
# Set up new MacOS machine
set -euo pipefail
IFS=$'\n\t'

USER=$(whoami)

# Program versions for installation
PYTHON_VERSION=3.7.3
RUBY_VERSION=2.6.3

echo -e "\n \e[32m Setting up Dev Env \e[0m"
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sudo chown -R $USER:$(id -gn $USER) ~/.config

echo -e "\n \e[32m Installing Packages \e[0m"
brew install curl wget git tree htop vim tmux zsh zsh-completions bat gnu-time grep
brew install python3 node go gcc
brew install chromedriver imagemagick pandoc lynx cloc diff-so-fancy
brew install gpgme pyenv rbenv nvm
brew install docker docker-compose

echo -e "\n \e[32m Installing Apps \e[0m"
brew cask install google-chrome visual-studio-code iterm2 ngrok
brew cask install spotify vlc gimp postman karabiner-elements

echo -e "\n \e[32m Setting up Terminal \e[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)
sudo chsh -s $(which zsh)

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

brew untap caskroom/fonts
brew tap homebrew/cask-fonts
brew cask install font-fira-code font-source-code-pro font-hack-nerd-font font-victor-mono

rbenv install ${RUBY_VERSION}
rbenv global ${RUBY_VERSION}
gem install bundler
gem update --system

pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}
pip install --upgrade pip pipenv black flake8 rope ipython httpie requests cookiecutter youtube-dl

ruby --version
node --version
go version
python --version
