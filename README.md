# Dotfiles
> *Configuration files for zsh, bash, vim, tmux, git, Sublime Text 3, and VSCode*

### Table of Contents
* [Installation](#installation)
* [Screenshots](#screenshots)
* [References](#references)

### Installation
Clone the git repository:
```bash
$ git clone https://github.com/nirantak/dotfiles.git ~/dotfiles
```

Install necessary dependencies
```bash
$ sudo apt update
$ sudo apt install git curl wget vim zsh tmux
```

Install additional software
* [Sublime Text 3](https://www.sublimetext.com/3)
* [Visual Studio Code](https://code.visualstudio.com/Download)
* [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
* [Vundle](https://github.com/VundleVim/Vundle.vim)
* [Powerline](https://github.com/powerline/powerline)
* [Powerline Fonts](https://github.com/powerline/fonts)

Run the setup script
```bash
$ bash ~/dotfiles/make.sh
```
Old dotfiles are backed up in `~/dotfiles/dotfiles_old`

### Screenshots
* Zsh  
![zsh](images/zsh.png)

* Bash  
![bash](images/bash.png)

* Vim  
![vim](images/vim.png)

* Tmux  
![tmux](images/tmux.png)

### References
* [GitHub dotfiles](http://dotfiles.github.io/)
* [Mathias Bynens'](https://github.com/mathiasbynens/dotfiles) dotfiles

