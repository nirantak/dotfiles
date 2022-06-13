#!/bin/bash
# ~/dotfiles/setup.sh
# This script creates symlinks from dotfiles dir to their respective locations
set -euo pipefail
IFS=$'\n\t'


SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

dir=~/dotfiles
oldDir=~/dotfiles/dotfiles_old

# Terminal config

files=( "shell/.bash_profile" "shell/.bashrc" "shell/.zshenv" "shell/.zshrc" "shell/.inputrc" "shell/.editrc" "tools/.prettierrc" "tools/.tmux.conf" "tools/.vimrc" "git/.gitconfig" )

echo "Creating $oldDir for backup of any existing dotfiles"
mkdir -p "$oldDir/{shell,tools,git}"

echo "Changing to the $dir directory"
cd $dir

echo "Moving existing dotfiles from ~ to $oldDir"
for file in "${files[@]}"; do
  filename=$(basename $file)
  filedir=$(dirname $file)

  if [ -f ~/$filename ]; then
    mv ~/$filename $oldDir/$filedir/
  fi
  echo "Creating symlink to $filename"
  ln -svf $dir/$file ~/$filename
done

# VSCode config

vsFiles=( "settings.json" "keybindings.json" )
if [[ "$OSTYPE" == "darwin"* ]]; then
  vsPath=~/Library/Application\ Support/Code/User
else
  vsPath=~/.config/Code/User
fi

echo "Moving existing dotfiles from $vsPath to $oldDir/vscode"
mkdir -p $vsPath
mkdir -p "$oldDir/vscode"

for file in "${vsFiles[@]}"; do
  if [ -f $vsPath/$file ]; then
    mv $vsPath/$file $oldDir/vscode/
  fi
  echo "Creating symlink to $file"
  ln -svf $dir/vscode/$file $vsPath/$file
done

# restore $IFS
IFS=$SAVEIFS

echo -e "\x1B[32m*Complete*\x1B[0m"
