## ~/.xinitrc


#dbus-update-activation-environment --systemd DISPLAY
dbus-update-activation-environment --systemd --all

# Import env-var DISPLAY manually, in case the absence of a display
# manager prevents the DISPLAY env-var from being correctly set.
systemctl --user import-environment DISPLAY
    # Last edit: 2020.05.06 at 23:10:15 [ckb]

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# Load key bindings (before calling window manager)
xbindkeys

includes=/etc/X11/xinit/xinitrc.d
if [ -d "$includes" ]; then
    for f in "$includes/"*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
unset includes

# Run Gnome on Xorg session only
export XDG_SESSION_TYPE=x11
export DE="gnome"
#export GDK_SYNCHRONIZE=1
exec gnome-session
