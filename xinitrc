## ~/.xinitrc


dbus-update-activation-environment --systemd DISPLAY

# Import env-var DISPLAY manually, in case the absence of a display
# manager prevents the DISPLAY env-var from being correctly set.
systemctl --user import-environment DISPLAY
    # Last edit: 2020.05.06 at 23:10:15 [ckb]

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Load key bindings (before calling window manager)
xbindkeys

# Run Gnome on Xorg session only
export XDG_SESSION_TYPE=x11
export DE="gnome"
exec gnome-session

