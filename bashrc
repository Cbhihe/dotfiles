#!/usr/bin/bash

# File: ~/.bashrc
# Last edit: 2020.11.04 at 17:10 [ckb]
# Executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# -----------------------------------------------------------------------

# If not running interactively, don't do anything
case $- in
    # $- expands to current option flags, specified with either `set'
    # (builtin), or `-i' upon shell invocation.
    *i*)
        GPG_TTY="$( tty )"
        export GPG_TTY
        # set Readline cmd editing mode to vi instead of emacs defaults
        set -o vi ;;
      *)
          return;;
esac

# Make 'less' more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#shellcheck disable=SC1090
# load key bindings
xbindkeys

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? -eq 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\''\)"'

# ==================================================
##  Mail     {{{1
#   (from https://gist.github.com/jan-warchol/sync-history.sh)
MAILPATH="/var/spool/mail/ckb?$_ has email!"
MAILCHECK=60
#   }}}1

# ==================================================
##  History    {{{1
# Suppress duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTFILE=$HOME/.bash_history    # Default
HISTTIMEFORMAT='%F %T - '; export HISTTIMEFORMAT
#HISTTIMEFORMAT="%Y%m%d %T - "
# Ignore specific commands (full length match)
HISTIGNORE="?:cd:ls:ll:bg:fg:cdv:lsa:h:hi:his:hist:histo:histor:history"
HISTSIZE=300                    # Default: 500
HISTFILESIZE=1200               # Default: HISTZISE
HISTCONTROL=ignoreboth
# If "ignoreboth" is commented out, history records all command lines
#+ entered after a prompt, including those beginning with a space and
#+ duplicated CMDs. In that case, it is better to use \# in prompt PS1
#+ (counts number of shell prompts in sessions), instead of \! (displays
#+ last entry rank in hist stack +1)

# Append to the history file, don't overwrite it
shopt -s histappend

# backup of history file at most every 30 minutes
#  test result of `find` for file modified 30min before or less
# [ foo = foo"$(find "$HISTFILE".backup~ -mmin -30 2>/dev/null)" ] \
# [ -z "$(find "$HISTFILE".backup~ -mmin -30 2>/dev/null)" ] \
! [ "$(find "$HISTFILE".backup~ -mmin -30 2>/dev/null)" ] \
    && { \rm -f "$HISTFILE".backup~ 2>/dev/null; \
    /usr/bin/cp --force --backup "$HISTFILE" "$HISTFILE".backup~; }
# `{ list; of; commands;}'
# allows group execution of cmds' list in current shell

# define history interactive editor (used with 'fc -e')
export FCEDIT='/usr/bin/vim'

# Synchronize all current interactive shells' histories
# Modified from:
# https://gist.github.com/jan-warchol/89f5a748f7e8a2c9e91c9bc1b358d3ec
# Last edit: 2020.04.30 at 17:53:07 [ckb]
source /opt/scripts/sync-history.sh

# Check history expansions before running the command
# If disabled, this option can be temporarily replaced by appending :p to
# history expansion, as in: '> !n:p`  where n is the history command number
shopt -s histverify   # made redundant using 'magic-space' in ~/.inputrc
# }}}1

# ==================================================
## Env-var and shell options   {{{1

# Sane backend config requirements   
#SANE_USB_WORKAROUND=1 ; export SANE_USB_WORKAROUND

# 'basic calculator' bc'
#BC_ENV_ARGS=~/.; export BC_ENV_ARGS

# Set standard default text editor
#VISUAL=/usr/bin/vim; export VISUAL # ensures 'nano' not used with 'visudo'
# -> ensures 'vim' is used for 'sudoedit FILENAME' or 'sudo -e FILENAME'
# so no arbitrary shell command may run from the editor with sudo privileges.
#SUDO_EDITOR=/usr/bin/vim; export SUDO_EDITOR
#SYSTEMD_EDITOR=/usr/bin/vim; export SYSTEMD_EDITOR

# Change to directory immediately if name typed at prompt exist.
shopt -s autocd

# Check window size after each command and, if necessary, update the values
# of LINES and COLUMNS. (redundant if /etc/bash.bashrc is correctly called
# for interactive terminals)
#shopt -s checkwinsize

# If set, the pattern "**" used in a path-name expansion context will
# match all files and zero or more directories and sub-directories.
# shopt -s globstar

# In other locales the ERE [a-d] is typically not equivalent to [abcd];
# it might be equivalent to [aBbCcDd], for example. To obtain the
# traditional interpretation of bracket expressions, use the C locale
#LC_ALL="C" ; export LC_ALL

#  }}}1

# ==================================================
## Enable programmable completion features  {{{1
# Enabling is not needed if already done in '/etc/bash.bashrc'
# or in '/etc/profile'.
# Source `/etc/bash.bashrc'
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    #shellcheck disable=SC1091
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    #shellcheck disable=SC1091
    . /etc/bash_completion
  fi
fi
# }}}1

# ==================================================
##  Git   {{{1
parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'; }

#git config --global --add color.ui true
export GIT_PS1_SHOWDIRTYSTATE="enable"
export GIT_PS1_SHOWSTASHSTATE="enable"
#    }}}1

# ==================================================
##  Vim plugins  {{{1
# Add vim plugin submodule repository (`$1') at given path (`$2')
# to the change-set to be committed next to current project
#vpa() { git -C ~/.vim/pack/plugins/"$2" submodule add "$1"; }

# vim plugin update
vpu() {
    for dirn in "$HOME"/.vim/pack/plugins/{opt,start}; do
        if [ -n "$(\ls -A "$dirn")" ]; then
            for f in "$dirn"/*; do
                echo "$f" && git -C "$f" pull --recurse-submodules
            done
        fi
    done
}

# vim plugin delete
vpd() {
    # place content of .../opt/ and .../start/ in integer-indexed
    # arrays 'a_opt' and 'a_sta'
    a_opt="$(\ls -A "$HOME"/.vim/pack/plugins/opt)"
    a_sta="$(\ls -A "$HOME"/.vim/pack/plugins/start)"

    if  [ -n "$a_opt" ]; then
        for f in "$HOME"/.vim/pack/plugins/opt/*; do
            if [ "$1" = "$f" ]; then
                git -C ~/.vim/pack/plugins/opt submodule deinit "$1" &&
                git -C ~/.vim/pack/plugins/opt rm "$1"
                break
            fi
        done
    elif [ -z "${a_sta}" ]; then
        for f in "$HOME"/.vim/pack/plugins/start/*; do
            if [ "$1" = "$f" ]; then
                git -C ~/.vim/pack/plugins/start submodule deinit "$1" &&
                git -C ~/.vim/pack/plugins/start rm "$1"
                break
            fi
        done
    else
        echo "Error: Plugin $1 not found."
    fi
}
#   }}}1

# ==================================================
## Color     {{{1
# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color)
        color_prompt=yes;;
esac

# Comment for a non colored prompt, when the terminal has the capability
# Turned off by default to not distract the user.
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi
#    }}}1

# ==================================================
## Cursor style    {{{1

# CSI Ps SP q   (where control sequence insert (CSI) is '\033[')
#     Set cursor style (DECSCUSR), VT520.
#     Ps = 0  -> blinking block.
#     Ps = 1  -> blinking block (default).
#     Ps = 2  -> steady block.
# >>  Ps = 3  -> blinking underline.
#     Ps = 4  -> steady underline.
#     Ps = 5  -> blinking bar (xterm).
#     Ps = 6  -> steady bar (xterm).

# CAUTION: this is terminal specific !
if [ "$color_prompt" = yes ]; then
    printf '%b' '\033[3 q'   # set to blinking underscore
fi

# cursor modifiers can also be introduced in PS1 (prompt) definition.
#cursor_background_black=0
#cursor_background_red=64
#cursor_foreground_yellow=12
#cursor_style_underscore=2
#cursor_styles="\e[?${cursor_style_underscore};${cursor_foreground_yellow};${cursor_background_red};c"

#    }}}1

# ==================================================
##  Prompt    {{{1
# Set variable identifying the chroot you work in (used in prompt below for Debian envt)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# Get name of current Python version via pyenv.
# Get 'pyenv' global python version (include VEs via pyenv-virtualenv)
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Snippet adapted from github.com/jackmaney/bash-profile/blob/master/.bash_profile#L19
pyenv_py_ver(){
    py_version=""
    if [ -n "$(command -v pyenv 2>/dev/null)" ]; then
        if hash pyenv 2>/dev/null; then
            py_version="$(python --version | cut -d' ' -f2 2> /dev/null)"
            #py_version_short="$(awk '{print substr($0,1,length($0)-1)}' 2>/dev/null)<<< $py_version)"
        fi
    else
        # default to system python version if 'pyenv' not installed
        py_version="$(/usr/bin/python --version | cut -d' ' -f2 2>/dev/null)"
    fi
    [ -n "$py_version" ] && echo "$py_version"
}

if [ "$color_prompt" = yes ]; then

    # For Debian based systems only
    #export PS1='${debian_chroot:+($debian_chroot)}[\#]\[\e[01;34m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]$'
    # Improved with:
    #PS1="${debian_chroot:+($debian_chroot)}\[\e[0;38;5;166m\][\#/\!]\[\e[1;34m\] \w\[\e[38;5;46m\] \$(parse_git_branch)\[\e[1;38;5;166m\]>\[\e[0m\]"

    # For Archlinux
    # [ckb 20171203, 20180922] replaced PS1
    #PS1="\\[\\e[0;38;5;166m\\][\\#/\\!]\\[\\e[2;33m\\]\$(pyenv_py_ver)\\[\\e[22;1;34m\\] \\w\\[\\e[38;5;46m\\] \$(parse_git_branch)\\[\\e[1;38;5;166m\\]\> \\[\\e[0m\\]"
    PS1="\[\e[0;38;5;166m\][\#/\!]\[\e[2;33m\]\$(pyenv_py_ver)\[\e[22;1;34m\] \w\[\e[38;5;46m\] \$(parse_git_branch)\[\e[1;38;5;166m\]\> \[\e[0m\]"

else
    # For Debian based systems only
    #export PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    #export PS1="${debian_chroot:+}[\#/\!] \[\w \$(parse_git_branch)\]>"

    # For Archlinux
    # [ckb 20171203, 20180922] replaced PS1
    PS1="[\\#/\\!]\$(pyenv_py_ver) \\[\\w \$(parse_git_branch)\\]\>"
fi
export PS1

unset color_prompt force_color_prompt

# If this is an xterm set the tile to 'tty tty_number::username@hostname::dir'
case "$TERM" in
    xterm*|rxvt*)

        # For Debian based systems
        #PS1="\[\e]0;tty $(tty|awk '{print substr($1,10)}') :: [${debian_chroot:+($debian_chroot)}] \u@\h \w\a\]$PS1"
        #export PS1 ;;

        # For Archlinux
        PS1="\\[\\e]0;tty $(tty|awk '{print substr($1,10)}') :: \\u@\\h \\w\\a\\]$PS1"
        export PS1
        ;;
    *)
        ;;
esac
#     }}}1

# ==================================================
## Aliases     {{{1
# Put all alias definitions in ~/.bash_aliases
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
[ -f "$HOME"/.bash_aliases ] && source "$HOME"/.bash_aliases
#    }}}1

# ==================================================
## Tor    {{{1
# Set shells to use `torsocks` prefix as default for any cmd.
#source torsocks on
# To disable `torsocks` for current shell
#source torsocks off
#    }}}1

# ==================================================
## Node.js    {{{1
# Node Version Manager
# Simple bash script to manage multiple active node.js versions
source /usr/share/nvm/init-nvm.sh
#   }}}1

# ==================================================
## Python virtual environments    {{{1
# PYENV_ROOT, PROJECT_HOME ... defined in ~/.profile

# Make sure `eval "$(pyenv init -)"` is placed at end of ~/.bashrc
#+ since it manipulates PATH
[ -n "$(command -v pyenv)" ]  && eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"
# 'pyenv virtualenv-init -' will automatically activate and deactivate VEs as long as $PWD
#+ contains file .python-version listing the name of a valid VE as shown in the output of
#+ 'pyenv virtualenvs'

# Other previous attempts at automation   {{{2
#/usr/bin/python --version | cut -d' ' -f2 >| "${PYENV_ROOT}"/version
# Useful if latest rolling release version is ahead of versions available for pyenv to install
#pyenv global "$(tail -1 <( sed '/[a-zA-Z]/d;s/^[ \t]*//' <(pyenv install --list) ))"
#pyenv global "$(tail -1 <( sed -n '/^[ ]*3\.[0-9]\+\.[0-9]\+[a-z]\?[0-9]*$/p' <(pyenv install --list) ))"
#pyenv global "$(tail -1 <( sed -n 's/^[ ]*\(3\.[0-9]\+\.[0-9]\+$\)/\1/p' <(pyenv install --list) ))"
#pyenv global "$(/usr/bin/python --version | cut -d ' ' -f2 2>/dev/null)"
#     }}}2

latest_available="$(tail -n 1 < <(sed -n -E 's/^\s*//;/^[0-9]+[^a-z]+[0-9]$/p' < <(pyenv install --list)))"
mapfile -t installed < <(pyenv versions)
#mapfile -t installed < <(pyenv versions | cut -c3- | cut -d' ' -f1)
if ! grep -q "$latest_available" < <(echo "${installed[@]}"); then
    #pyenv install "$latest_available"
    #pyenv global "$latest_available"
    :
else
    #pyenv global "$latest_available"
    :
fi
pyenv global 3.10.0     # change manually for every new major version
/usr/bin/echo "$(pyenv global)" >| "${PYENV_ROOT}"/version

#    }}}1

