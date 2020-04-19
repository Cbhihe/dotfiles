# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# sync Fx cache  and profile (located in tmpfs on RAM) just before logout.
/home/ckb/Scripts/fxram-sync cache
/home/ckb/Scripts/fxram-sync profile
