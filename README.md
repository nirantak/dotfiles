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

Or for full system setup, see repo [nirantak/infra-automation](https://github.com/nirantak/infra-automation). Run any of the [bootstrap scripts](https://github.com/nirantak/infra-automation/tree/main/scripts).

Install additional software (Included in bootstrap scripts)

- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [Visual Studio Code](https://code.visualstudio.com/Download)
- [Powerline](https://github.com/powerline/powerline)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Meslo Font](https://github.com/romkatv/powerlevel10k#fonts)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

Run the setup script

```bash
~/dotfiles/setup.sh
```

Old dotfiles are backed up in `~/dotfiles/dotfiles_old`

## Screenshots

- Zsh

![zsh](.github/images/zsh.png)

- Vim

![vim](.github/images/vim.png)

## References

- [GitHub dotfiles](http://dotfiles.github.io/)
- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles)
