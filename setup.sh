#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# setup.sh
# This script creates symlinks from dotfiles dir to their respective locations

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

dir=~/dotfiles
oldDir=~/dotfiles/dotfiles_old
files=( ".bash_profile" ".bashrc" ".prettierrc" ".tmux.conf" ".vimrc" ".zshenv" ".zshrc" ".gitconfig" ".inputrc" ".editrc")

vsFiles=( "settings.json" "keybindings.json" )
if [[ "$OSTYPE" == "darwin"* ]]; then
  vsPath=~/Library/Application\ Support/Code/User
else
  vsPath=~/.config/Code/User
fi

echo "Creating $oldDir for backup of any existing dotfiles"
mkdir -p "$oldDir/shell"
mkdir -p "$oldDir/vscode"
echo "...complete."

echo "Changing to the $dir directory"
cd $dir

echo "Moving existing dotfiles from ~ to $oldDir"
for file in "${files[@]}"; do
  if [ -f ~/$file ]; then
    mv ~/$file $oldDir/shell/
  fi
  echo "Creating symlink to $file"
  ln -s $dir/shell/$file ~/$file
done

echo "Moving existing dotfiles from $vsPath to $oldDir/vscode"
mkdir -p $vsPath
for file in "${vsFiles[@]}"; do
  if [ -f $vsPath/$file ]; then
    mv $vsPath/$file $oldDir/vscode/
  fi
  echo "Creating symlink to $file"
  ln -svf $dir/vscode/$file $vsPath/$file
done

# restore $IFS
IFS=$SAVEIFS

echo "Installing Vundle plugins in Vim..."
vim +PluginInstall +qall

echo -e "\e[32m*Complete*\e[0m"
