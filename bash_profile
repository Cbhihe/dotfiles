#!/usr/bin/bash

#set -x    # For debugging, visualize all instructions as they are executed

# ##################
# ~/.bash_profile
# ##################

# This file is only sourced by the shell when started in interactive LOGIN
#+ mode or in non-interactive LOGIN mode with the '--login' option
#+ activated. This occurs via login at the console (Ctrl+Alt+F1|F2|...|F6) or
#+ upon connect via ssh.

# In interactive LOGIN mode, `/etc/profile` is always executed first. Then
# if ~/.bash_profile  does not exist, the shell looks for ~/.bash_login.
# If ~/.bash_login does not exist, the shell looks for ~/.profile
# If ~/.profile is not there, the shell gives a prompt. In that case, by
# default, `.bashrc` is not read, unless arranged otherwise by sys-admin.

# Prior to 'bash' execution, other files are read by the linux PAM layer:
#+ /etc/pam.d/login
#+ /etc/pam.d/login.defs
#+ [more files depending on Linux distro ...]
#+ /etc/profile

# "ssh" login is very similar to the above except that initial greeting
#+ and password authentication will be conducted, not by getty and login via
#+ PAM, but by sshd. In that case the ssh deamon, sshd, reads successively:
#+ /etc/pam.d/ssh
#+ /etc/pam.d/ssh.defs
#+ [more files depending on linux distro ...]
#+ /etc/profile
# The main difference with local console login is some environment variables
#+ may be passed on from the machine-session on which ssh is being run (e.g.
#+ the LANG and LC_* variables). More on https://wiki.debian.org/Locale

# When login occurs via gui:
#+ Normally the shell is NOT a LOGIN shell (unless invoked with cmd 'bash -l'.
#+ As a result ~/.profile will be sourced by the script that launches the
#+ gnome session (or any other desktop environment). ~/.bash_profile will not
#+ be sourced at all when gui login occurs.
# Note: if cmd 'shopt login_shell' returns "off", then shell is no login shell.

# Ensure that .bashrc, config file for interactive instances of bash shells,
#+ gets read even when the shell is a login shell
#source "${HOME}"/.bashrc

# PATH and other environment variables
# The right place to define PATH and other env vars is usually `~/.profile` (or
# in `.bash_profile` (if you don't care for shells other than `bash`).

# Per Gilles' answer #88106 on SE (Aug. 25, 2013)
source "$HOME"/.profile
case "$-" in
    *i*) source "$HOME"/.bashrc ;;
    *) : ;;
esac

# Enable the keyring for applications run through the terminal, such as SSH
if [ -n "$DESKTOP_SESSION" ];then
    eval "$(gnome-keyring-daemon --start)"
    export SSH_AUTH_SOCK
fi

#if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] ; then
#     exec startx
#fi

# ===========================================================

# Sync Fx cache and profile (located in tmpfs on RAM) at login
#/home/ckb/Scripts/fxram-sync cache
#/home/ckb/Scripts/fxram-sync profile
