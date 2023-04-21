#!/bin/bash
# ~/dotfiles/setup.sh
# This script creates symlinks from dotfiles dir to their respective locations
set -euo pipefail
IFS=$'\n\t'
REPO_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Terminal config
files=( "shell/.bashrc" "shell/.zshenv" "shell/.zshrc" "shell/.inputrc" "shell/.editrc" "tools/.prettierrc" "tools/.tmux.conf" "tools/.vimrc" "git/.gitconfig" )

echo "Moving existing dotfiles from ~ to $oldDir"
for file in "${files[@]}"; do
  filename=$(basename $file)
  filedir=$(dirname $file)

  if [[ -f ~/$filename && ! -L ~/$filename ]]; then
    # Backup old dotfile if not a symlink
    mv ~/$filename ~/$filename.$(date +%s).bak
  fi
  echo "Creating symlink to $filename"
  ln -svf $REPO_DIR/$file ~/$filename
done

# VSCode config
vsFiles=( "settings.json" "keybindings.json" )

if [[ "$OSTYPE" == "darwin"* ]]; then
  vsPath=~/Library/Application\ Support/Code/User
else
  vsPath=~/.config/Code/User
fi

echo "Setting up VSCode configs in $vsPath"
mkdir -p $vsPath

for file in "${vsFiles[@]}"; do
  if [[ -f $vsPath/$file && ! -L $vsPath/$file ]]; then
    # Backup old config if not a symlink
    mv $vsPath/$file $vsPath/$file.$(date +%s).bak
  fi
  echo "Creating symlink to $file"
  ln -svf $REPO_DIR/vscode/$file $vsPath/$file
done

# restore $IFS
IFS=$SAVEIFS

echo -e "\x1B[32m*Complete*\x1B[0m"
