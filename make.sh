#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# make.sh
# This script creates symlinks from dotfiles dir to their respective locations

SAVEIFS=$IFS
IFS=$(echo -en "\n\b") #internal field seperator

dir=~/dotfiles
oldDir=~/dotfiles/dotfiles_old
files=( ".bash_profile" ".bashrc" ".tmux.conf" ".vimrc" ".zshenv" ".zshrc" )
sublimeFiles=(
    "Preferences.sublime-settings"
    "Package Control.sublime-settings"
    "Default (Linux).sublime-keymap"
    "Default (Linux).sublime-mousemap"
    "Anaconda.sublime-settings"
    "Distraction Free.sublime-settings"
    "Markdown.sublime-settings"
    "Python-3.sublime-build"
    )
vsFiles=( "settings.json" "keybindings.json" )

echo "Creating $oldDir for backup of any existing dotfiles"
mkdir -p "$oldDir/shell"
mkdir -p "$oldDir/sublime"
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

echo "Moving existing dotfiles from ~/.config/sublime-text-3/Packages/User to $oldDir/sublime"
for file in "${sublimeFiles[@]}"; do
    if [ -f ~/.config/sublime-text-3/Packages/User/$file ]; then
        mv ~/.config/sublime-text-3/Packages/User/$file $oldDir/sublime/
    fi
    echo "Creating symlink to $file"
    ln -s $dir/sublime/$file ~/.config/sublime-text-3/Packages/User/$file
done

echo "Moving existing dotfiles from ~/.config/Code/User to $oldDir/vscode"
for file in "${vsFiles[@]}"; do
    if [ -f ~/.config/Code/User/$file ]; then
        mv ~/.config/Code/User/$file $oldDir/vscode/
    fi
    echo "Creating symlink to $file"
    ln -s $dir/vscode/$file ~/.config/Code/User/$file
done

# restore $IFS
IFS=$SAVEIFS

echo "Installing Vundle plugins in Vim..."
vim +PluginInstall +qall

echo -e "\e[32m*Complete*\e[0m"
