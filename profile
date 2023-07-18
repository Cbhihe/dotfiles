#!/usr/bin/bash

# ###############
# $HOME/.profile
# ###############

# This file is immediately parsed and sourced by GDM's login manager upon GUI login.
# When login is through an interactive login shell, it is parsed after `/etc/profile`,
# provided the files `~/.bash_profile`, `.bash_login` do NOT exist.
#
# Our PATH segments are defined here, because `~/.bash_profile` actually sources this
# `~/.profile`.  This is recommended because when defining environmental variables only
# in `~/.bash_profile` only the `bash` shell has access to them.

# ###############
# Readline startup file
# ###############
# Handle reading input when in interactive shell
INPUTRC="$HOME"/.inputrc; export INPUTRC     # default: ~/.inputrc

# #########
# LANG
# #########
# Probably already set globally for the system
LANG=en_US.UTF-8; export LANG

# #########
# LC_ALL
# #########
# Set local environment variable for locale
# In other locales the ERE [a-d] is typically not equivalent to [abcd];
# interpretation of bracket expressions, use the C locale
#LC_ALL=C; export LC_ALL

# #########
# POSIXLY_CORRECT
# #########
# Enforce a POSIX compliant env.
# This may break things (e.g. Unity desktop on Ubuntu 14.04)
#POSIXLY_CORRECT=1; export POSIXLY_CORRECT

# #########
# INPUT METHOD FRAMEWORK (IMF)
# #########
# Evars below are defined in /etc/environment
#GTK_IM_MODULE=ibus; export GTK_IM_MODULE
#QT_IM_MODULE=ibus; export QT_IM_MODULE
#XMODIFIERS=@im=ibus; export XMODIFIERS

# #########
# VISUAL, EDITOR, SUDO_EDITOR, SYSTEMD_EDITOR
# #########
# Set default text editor to make sure that 'vim' is used with 'visudo'
VISUAL=/usr/bin/vim ; export VISUAL
# When set, VISUAL prevails on env-var EDITOR
#set EDITOR=vim; export EDITOR
SUDO_EDITOR=/usr/bin/vim; export SUDO_EDITOR
SYSTEMD_EDITOR=/usr/bin/vim; export SYSTEMD_EDITOR

# #########
# HADOOP
# #########
HADOOP_HOME=/opt/hadoop; export HADOOP_HOME

# #########
# JAVA
# #########
JAVA_HOME=/usr/lib/jvm/java-8-openjdk; export JAVA_HOME

# #########
# SPARK
# #########
SPARK_HOME=${HOME}/spark/spark; export SPARK_HOME

# #########
# PYTHON
# #########
PYTHONSTARTUP="${HOME}/.pyrc"; export PYTHONSTARTUP
if [ -n "$PYTHONPATH" ]; then
    # env-var is not null-string
    PYTHONPATH=${PYTHONPATH}:"${HOME}/Documents/Work/Projects"
else
    # env-var is null-string
    PYTHONPATH="${HOME}/Documents/Work/Projects"
fi
#PYTHONBREAKPOINT=pdb.set_trace; export PYTHONBREAKPOINT  # for debugging with 'pdb'
PYTHONBREAKPOINT=pudb.set_trace; export PYTHONBREAKPOINT  # for debugging with 'pudb'

# PYENV virtual environment
PYENV_ROOT="${HOME}"/.pyenv; export PYENV_ROOT

# VIRTUALENV's virtualenvwrapper plugin
WORKON_HOME="${HOME}"/.virtualenvs; export WORKON_HOME
mkdir -p "$WORKON_HOME"
PROJECT_HOME="${HOME}"/Documents/Work/Projects/BSC/Sgoab/Src; export PROJECT_HOME

NLTK_DATA="/var/data/nltk_data/"; export NLTK_DATA

# #########
# PATH
# #########
# Notes of caution:
# Do not add path segments in front of PATH as the order of priority for sourcing
# executable files in PATH is from left to right.  Misplacing new PATH segments at
# the beginning of PATH would radically modify the picking order when looking for
# executable files.
# This is also meant as a good practice as an attacker could potentially replace
# an innocuous looking cmd by something else in front of the PATH env var.
# Use $HOME/ instead of ~/ in PATH for portability

PATH=$PATH:/opt/bin:/opt/scripts
PATH=$PATH:${HOME}/Documents/Scripts # use $HOME/ instead of ~/ for portability
PATH=$PATH:${HOME}/.local/bin
PATH=$PATH:${HADOOP_HOME}/bin
PATH=$PATH:${SPARK_HOME}/bin
PATH=${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:$PATH   # note that PATH is pre-pended

# #########
# PATH CLEANING
# #########
PATH=$(/opt/scripts/pathclean PATH "$PATH")
export PATH             # only necessary for the old Bourne shell.

PYTHONPATH=$(/opt/scripts/pathclean PYTHONPATH "$PYTHONPATH")
export PYTHONPATH       # only necessary for the old Bourne shell.

# Make sure that systemd is made aware of custom PATHs.
# This does NOT affect services started before `.bash_profile` is sourced.
systemctl --user import-environment PATH

