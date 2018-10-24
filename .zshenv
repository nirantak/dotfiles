# Load environment variables
[ -r ~/.exports ] && [ -f ~/.exports ] && source ~/.exports;

# Start Gnome Keyring
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
