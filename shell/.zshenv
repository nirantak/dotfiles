# Load environment variables
[ -r ~/dotfiles/shell/exports.sh ] && [ -f ~/dotfiles/shell/exports.sh ] && source ~/dotfiles/shell/exports.sh;

if [[ "$OSTYPE" == "linux"* ]]; then
  # Start Gnome Keyring
  if [ -n "$DESKTOP_SESSION" ]; then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
  fi
fi
