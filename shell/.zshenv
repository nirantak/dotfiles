# Load environment variables
[ -r ~/dotfiles/shell/exports.sh ] && [ -f ~/dotfiles/shell/exports.sh ] && source ~/dotfiles/shell/exports.sh;

# Start Gnome Keyring
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
