# Dotfiles

> _Configuration files for zsh, bash, vim, tmux, git, and VSCode_

## Table of Contents

- [Dotfiles](#dotfiles)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Screenshots](#screenshots)
  - [References](#references)

## Installation

Clone the git repository:

```bash
git clone https://github.com/nirantak/dotfiles.git ~/dotfiles
```

Install necessary dependencies

```bash
brew install git curl wget vim zsh tmux
# OR
sudo apt update && sudo apt install -y git curl wget vim zsh tmux
```

Or for full system setup:

```bash
./scripts/bootstrap_mac.sh
# OR
./scripts/bootstrap_ubuntu.sh
```

Install additional software (Included in bootstrap scripts)

- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [Visual Studio Code](https://code.visualstudio.com/Download)
- [Vundle](https://github.com/VundleVim/Vundle.vim)
- [Powerline](https://github.com/powerline/powerline)
- [Powerline Fonts](https://github.com/powerline/fonts)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

Run the setup script

```bash
~/dotfiles/setup.sh
```

Old dotfiles are backed up in `~/dotfiles/dotfiles_old`

## Screenshots

- Zsh

![zsh](images/zsh.png)

- Bash

![bash](images/bash.png)

- Vim

![vim](images/vim.png)

## References

- [GitHub dotfiles](http://dotfiles.github.io/)
- [Mathias Bynens'](https://github.com/mathiasbynens/dotfiles) dotfiles
