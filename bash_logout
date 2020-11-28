#! /usr/bin/env bash

## ~/.bash_logout: executed by bash(1) when login shell exits.

# When leaving console clear screen to increase privacy
[ "$SHLVL" = 1 ] && [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q

# Always deactivate any active VE before exiting shell
[ "$VIRTUAL_ENV" ] && deactivate

# sync Fx cache  and profile (located in tmpfs on RAM) just before logout.
/home/ckb/Scripts/fxram-sync cache
/home/ckb/Scripts/fxram-sync profile
