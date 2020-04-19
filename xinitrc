## ~/.xinitrc


dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Load key bindings (before calling window manager)
xbindkeys

# Run Gnome on Xorg session only
export DE="gnome"
exec gnome-session

