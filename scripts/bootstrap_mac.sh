#!/bin/bash
# Set up a new MacOS machine
set -xeuo pipefail
IFS=$'\n\t'

USER=$(whoami)

# Program versions for installation
PYTHON_VERSION=3.9.7
RUBY_VERSION=3.0.2

echo -e "\n \x1B[32m Setting up Dev Env \x1B[0m"
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sudo chown -R $USER:$(id -gn $USER) ~/.config

echo -e "\n \x1B[32m Installing Packages \x1B[0m"
brew install curl wget git tree htop vim tmux zsh zsh-completions bat gnu-time gnu-sed gpgme grep
brew install python3 node go gcc pyenv rbenv nvm pandoc lynx imagemagick k9s
brew install autossh vnstat openvpn coreutils hping wrk mtr telnet cloudflare/cloudflare/cloudflared
brew install gh geckodriver cloc diff-so-fancy jq fzf ripgrep pipx hyperfine

echo -e "\n \x1B[32m Installing Apps \x1B[0m"
brew install --cask rectangle iterm2 istat-menus visual-studio-code
brew install --cask google-chrome firefox slack 1password zoom tunnelblick
brew install --cask docker insomnia beekeeper-studio mongodb-compass
brew install --cask gimp spotify vlc notion

echo -e "\n \x1B[32m Setting up Terminal \x1B[0m"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s $(which zsh)
sudo chsh -s $(which zsh)

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

$(brew --prefix)/opt/fzf/install --all

brew tap homebrew/cask-fonts
brew tap homebrew/services

brew install --cask font-fira-code font-source-code-pro font-hack-nerd-font font-victor-mono

rbenv install ${RUBY_VERSION}
rbenv global ${RUBY_VERSION}
gem install bundler
gem update --system

pyenv install ${PYTHON_VERSION}
pyenv global ${PYTHON_VERSION}

npm install -g browser-sync speed-test tldr eslint prettier
pip install -U pip wheel setuptools
pip install -U black flake8 ipython
for package in httpie youtube-dl pre-commit awscli;
  do pipx install $package;
done

ruby --version
node --version
go version
python --version
