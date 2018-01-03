#!/bin/bash
# make.sh
# This script creates symlinks from dotfiles dir to their respective locations

SAVEIFS=$IFS
IFS=$(echo -en "\n\b") #internal field seperator

dir=~/dotfiles
oldDir=~/dotfiles/dotfiles_old
files=( ".bash_aliases" ".bashrc" ".vimrc" ".zshrc" ".gitconfig" ".tmux.conf" )
sublimeFiles=(
	"Preferences.sublime-settings"
	"Package Control.sublime-settings"
	"Default (Linux).sublime-keymap"
	"Anaconda.sublime-settings"
	"Distraction Free.sublime-settings"
	"Markdown.sublime-settings"
	)
vsFiles=( "settings.json" )

echo "Creating $oldDir for backup of any existing dotfiles"
mkdir -p $oldDir
mkdir -p "$oldDir/sublime"
mkdir -p "$oldDir/vscode"
echo "...complete."

echo "Changing to the $dir directory"
cd $dir

echo "Moving existing dotfiles from ~ to $oldDir"
for file in "${files[@]}"; do
	mv ~/$file $oldDir/
	echo "Creating symlink to $file"
	ln -s $dir/$file ~/$file
done

echo "Moving existing dotfiles from ~/.config/sublime-text-3/Packages/User to $oldDir/sublime"
for file in "${sublimeFiles[@]}"; do
	mv ~/.config/sublime-text-3/Packages/User/$file $oldDir/sublime/
	echo "Creating symlink to $file"
	ln -s $dir/sublime/$file ~/.config/sublime-text-3/Packages/User/$file
done

echo "Moving existing dotfiles from ~/.config/Code/User to $oldDir/vscode"
for file in "${vsFiles[@]}"; do
	mv ~/.config/Code/User/$file $oldDir/vscode/
	echo "Creating symlink to $file"
	ln -s $dir/vscode/$file ~/.config/Code/User/$file
done

# restore $IFS
IFS=$SAVEIFS
echo -e "\e[32m*Complete*\e[0m"
