#!/usr/bin/bash
# ==================
# ~/.bash_aliases:
# ==================
# Executed by ~/.bashrc for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# select a default dictionary for basic system based spell-checking
#alias default-wordlist='sudo select-default-wordlist'

# shortcut to reload .bashrc and .bash_aliases after editing aliases
alias aliases='vim "$HOME"/.bash_aliases; source "$HOME"/.bash_aliases'

# History aliases  {{{1
alias history='\history 300'            # default
alias histor='\history 150'
alias histo='\history 75'
alias hist='\history 55'
alias his='\history 35'
alias hi='\history 25'
alias h='\history 15'
#  }}}1

# Common aliases    {{{1
# test for color db for ls and define env-var LS_COLORS
if [ -x /usr/bin/dircolors ]; then
    colopt="color=auto"

    if [ -r ~/.dircolors ] ; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
        # tweak default ls colors as seen outpi )ut from '> dircolors -p'
        LS_COLORS="${LS_COLORS}:tw=31;43:ow=01;37;43"
        export LS_COLORS
    fi

    alias less='\less -R'               # recognize dANSI color codes as input interpreted by term
    alias ls='\ls -F --color=auto'      # option -F to classify list items with */=>@|
    #alias ls='\ls -F --color=always | \less -r'
                                        # inoperative
    alias la='\ls -AC --color'          # list "almost all", by column
    alias lsa='\ls -AF --color=auto'
    alias lsi='\ls -1iqF --color=auto'  # list inode numbers and file names
    alias ll='\ls -lsiAF --time-style=+%Y%m%d-%H%M%S --color'
                                        # as before +long formats +size in blocks
    alias lc='\ls -CF --color=auto'     # list entry by column, classify
#   lld () {\ls -AlF --color=auto $1 | egrep "^d";}
                                        # long list dir only
    alias dir='dir -AF --color=auto'    # equal to '\ls -C -b -AF'
    alias vdir='vdir -AF --color=auto'  # equal to '\ls -l -b -AF'
    alias grep='grep --color=auto'
    alias sgrep='grep -Hn --color=auto' # grep with each match's filename and line nbr
    alias fgrep='fgrep --color=auto'
#   alias egrep='egrep --color=auto'     # deprecated
else
    colopt=""
    alias ls='\ls -F'                   # option -F to classify with */=>@|
    alias la='\ls -A'                   # list "almost all"
    alias lsa='\ls -AF'
    alias ll='\ls -lsAF --time-style=+%Y%m%d-%H%M%S'
                                        # as before +long formats +size in blocks
    alias lc='\ls -CF'                  # list entry by column, classify
    alias dir='dir -AF'                 # equal to '\ls -C -b -AF'
    alias vdir='vdir -AF'               # equal to '\ls -l -b -AF'
fi

alias diff='\diff -ybBi --suppress-common-lines'
                                        # ignore case, space changes, blank lines, common lines
                                        # display side by side
alias prename='/usr/bin/perl-rename'
alias crontab='\crontab -i'
alias lsblk='\lsblk -o +UUID'
#alias less='\less -R'                   # maintain screen appearance in presence
                                        #+ of ANSI "color" ecape sequences of type
                                        #+ 'ESC [ ... m`  where ... are zero or more
                                        #+ color spec characters.
alias cdl='cd -L'                       # follow symbolic links
alias cdp='cd -P'                       # use physical directory structure,
                                        #+ don't follow symbolic links

alias j='jobs -l'                       # option -l shows PID
#alias cat='cat -n'                      # Number all output lines
                                        # conflicts with 'pyenvvirtualenvwrapper' script
                                        # and 'workon' cmd.
                                        # [ckb] 2019.04.18 at 20:21:52 CEST
alias c='clear'
alias cl='clear'
alias claer='clear; echo "$(uname) assumed that command \clear\ was meant."'
alias bc='bc -lq'                       # Invoke builtin Unix calculator with
alias calc='bc -lq'                     #+ standard math library in quiet mode.

alias ps='\ps -eF --headers | less'
alias pstopcpu='\ps -auxf | sort -nr -k 4 | head -10'

# Screenshot
alias sshoot='/opt/scripts/screen-capture'
                                    # access to gnome-screenshot script
                                    # with custom save folder
# Safety nets
set -o noclobber                    # disallow clobbering file with output redirection '>'
alias ln='ln -i'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i --preserve-root'    # with -I flag, only asks when removing
                                    # 3 or more files
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root' # change group

alias df='df -kP'                   # check available space on volume of
                                    # named directory by default check all
                                    # mounted volumes

# alias cpprogress='rsync --progress -ravz'
                                    # cp with progress bar ??
# alias asuf='cp "$1" "$1""$2"'     # needs work

alias nocomment='grep -Ev '\''(#|$)'\'''
                                    # filter out comments in a grepped file

# Change directory verbosely
cdv () {
    # change dir + list target content
    case x"$1" in
        "x")
            #cd || exit ; \ls -AF --color=auto;;
            cd || return; \ls -AF --"$colopt" ;;
        *)
             [ -d "$1" ] &&  cd "$1" && \ls -AF --"$colopt" ;; #|| echo Not a directory.;;
    esac
        }

# Super 'ps'
sps() {
    # list ps while avoiding matching the 'grep' command line itself
    \ps aux | grep -E "$@" | grep -v 'grep';
}

# Disk space usage for non-root users
function finduserspace () {
    # print disk space usage for non-root users
    /usr/bin/awk -F: '/bash/ && /home/ {print "/home/"$1}' /etc/passwd | xargs -l sudo du -sm
}

alias userspace='finduserspace'

bgproc() {
    # print all background processes (works on Linux `procps` implementation of `ps`)

    \ps -eo pid,pgid,tpgid,args | /usr/bin/awk 'NR == 1 || ($3 != -1 && $2 != $3)';
}

#  1}}}

#  System + Hardware info aliases   {{{1
alias journalctl='journalctl -o short-precise'
alias lsmod='( \lsmod | \head -1 && \lsmod | \tail -n $(( $(\lsmod | \wc -l) -1 )) | \sort ) | \less'
                # srt 'lsmod' output while preserving standard header
alias battery='watch -n0 cat /sys/class/power_supply/BAT0/capacity'
                # display battery charge info in real time
alias swinfo='lsb_release -cd; printf "%s\t\t%s\n" "Kernel:" "$(uname -rsi)"'
                # prints distro specific info
alias cpuinfo='lscpu'
                # all info about the CPU
alias hwinfo1='\hwinfo'
alias hwinfo2='sudo dmidecode -q >| ~/Documents/Backups/hw-profile.txt; printf "%s\n" "Hardware profile in file: ~/Documents/Backups/hw-profile.txt"'
alias bioinfo='sudo dmidecode --type 0'  # requires sudo passwd
alias meminfo='sudo dmidecode --type 17' # requires sudo passwd
alias gpuinfo='lspci -k | grep -EA2 "VGA|3D"'

# send 'dmesg' content to pastebin
#    'curl -F': curl POSTs data as a filled form using the Content-Type multipart/form-data
#    ' <- ' when file-name is prefixed with '<' the file is actually treated as its text content
#       as obtained from stdin '-'
alias dmesg2bin='/usr/bin/dmesg | curl --upload-file - "http://paste.c-net.org/"'

# send 'journalctl -b' content to pastebin
alias bootjournal2bin='sudo /usr/bin/journalctl -b | curl --upload-file - "http://paste.c-net.org/"'

# Alert about long running commands.
# Usage: '$ sleep 10; alert '
alias alert='notify-send --urgency=low -i "$([ $? -eq 0 ] && echo terminal || echo error)" "$(history|tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\''\)"'

# Swappiness tweaking
# Default value of swappiness=60 means kernel starts swapping when RAM use
#+ hits 40% of available RAM capacity
# current session swappiness
alias swapinfo='printf "%s" "Current session swappiness is "; \cat /proc/sys/vm/swappiness'
# set swappiness for session
#alias setswap='printf "%s" "Current session swappiness set to: "; sudo ...=$1'

alias halt='sudo halt'              # halt processes and machine with no
alias reboot='sudo /sbin/shutdown -r'
                                    # arg is either "now" or an integer
                                    # value in minutes; same as 'sudo reboot'
alias shutdown='sudo /sbin/shutdown -h'
                                    # arg as above
#    1}}}

# date aliases    {{{1
alias datestamp='/usr/bin/date +%Y%m%d' # format yyyymmdd
alias timestamp='/usr/bin/date +%H%M%S' # format hhmmss
alias lastmod='/opt/bin/lastmod.sh' # last modif stamp by '$USER' (w/ CR)
alias partmod='/opt/bin/partmod.sh' # partial modif stamp by '$USER' (w/o CR)
alias scripthead='/opt/bin/scripthead.sh'
                                    # script creation stamp
alias date='/usr/bin/date | lolcat'
#     1}}}}

# vim  aliases   {{{1
alias svi='sudo -e'
alias svim='sudo -e'
alias edit='vim'
alias vimsi='vim "+set si"'         # vim with 'smartindent' option enabled
                                    # Similarly 'set ai', (autoindent) offers a less
                                    # sophisticated alternative to 'indentexpr' but
                                    # works in case the file type being edited remains
                                    # unrecognized
#    1}}}

# Erlang aliases    {{{1
# aplies to v16.b3
# alias erlg='erl -s toolbar' # start erlang with toolbar GUI applet
#   1}}}

# 'man' cmd overloading   {{{1
# overload 'man' -- allow info on builtins in pseudo man-page format
# Author: Radu Rädeanu in AU's question 439410
function man () {
    case "$(type -t -- "$1")" in
    builtin|keyword)
        help -m "$1" | sensible-pager
        ;;
    *)
        command man "$@"
        ;;
    esac
}
# 1}}}

# 'umount' cmd overloading   {{{1
# Overload `umount' -- allow unmounting in any situation
# Only one parameter (mount point or device path) is allowed
# Include special cases of 'root' user or lone option parameter
function umount () {
    if [ "$(id -un)" == "root" ] ||
       [ $# -ne 1 ] ||
       [ "${1:0:1}" == "-" ]; then
        command umount "$@"
    else
        /usr/bin/gvfs-mount -u "$1"
    fi
}
#    1}}}

# Disable mousepad temporarily  {{{1
# Disable Touchpad for given number of seconds
function padoff () {
    if [ ! $# -eq 1 ] ; then
        printf "Exactly one numeric argument (time in seconds) required.\\n"
        printf "Abort.\\n"
    else
        # strip all digits to test whether numeric
        isnbr="$(sed 's/[0-9]*//g' < <(echo "$1"))"
        if  [ -n "$isnbr" ]; then
            # if not zero length after stripping all digits
            printf "Argument must be numeric (time in seconds).\\n"
            printf "Abort.\\n"
        else
            ID_touchpad="$(cut -f1 < <(awk -F "=" '/Touchpad/ {print $2}' \
                < <(/usr/bin/xinput list)))"
            (/usr/bin/xinput --disable "${ID_touchpad}" ;
            printf "Touchpad disabled for the next %d seconds\\n" "$1";
            sleep "$1";
            /usr/bin/xinput --enable "${ID_touchpad}") &
        fi
    fi
}
#    1}}}

# Enable mousepad    {{{1
function padon () {
    ID_touchpad="$(cut -f1 < <(awk -F "=" '/Touchpad/ {print $2}' \
        < <(/usr/bin/xinput list)))"
    /usr/bin/xinput --enable "${ID_touchpad}"
    printf "Touchpad enabled.\\n"
}
# 1}}}

# Display members of a group   {{{1
# "group" is  provided as argument $1
function groupmember () {
    awk -F":" '{print $1, ": ", $4}' < <(grep -e "^${1}:.*" /etc/group)
}
alias grpmbr='groupmember'
#   1}}}

# Bash + utility cheat sheet  {{{1
function usage() {
    # yields usage examples for sought after cmds
    # accepts any number of cmd names as args
    cmd_name="$1"
    while [ -n "$cmd_name" ] ; do
        /usr/bin/curl cheat.sh/"${cmd_name}"  2>/dev/null | less
        shift
        cmd_name="$1"
    done
}
#    1}}}

# Network stuff    {{{1
alias ping='\ping -c 5'

# find available wlan networks in vicinity
alias wifiscan='sudo /usr/bin/iw wifi0 scan | grep -E "SSID:"'
alias wifistatus='sudo /usr/bin/wpa_cli -i wifi0 status'
alias wifinetworks='sudo iw dev wifi0 scan | grep -E "SSID|signal" | head -n30'

function locate_ip() {
    # find out where an exit node is geolocated
    [ $# != 1 ] && printf "\nPlease provide exactly one IP address as argument.\n\n" && return
    /usr/bin/curl -s ipinfo.io/"$1"
    #printf "\n"
}

function tor_exit_node_ip() {
    # find my tor exit node using third party platform, from cli
    #exit_ip_address="$(/usr/bin/curl -s --socks5-hostname localhost:9150 https://api.iplocation.net/? | awk -F'[ |<]{1,}' '/>Your IP</ {print $9}')"
    #awk '/"country":/ || /"ip":/ {print $0}' < <(locate_ip "$exit_ip_address") | sed -e 's/,$//'
    #jq '.country,.ip' < <(locate_ip "$exit_ip_address")
    #exit_ip_json="$(/usr/bin/curl -s --socks5-hostname localhost:9150 ipinfo.io/json)"
    exit_ip_json="$(/usr/bin/curl -s --socks5-hostname localhost:9150 ipinfo.io)"
    city="$(jq -r '.city' <<< "$exit_ip_json")"
    country="$(jq -r '.country' <<< "$exit_ip_json")"
    ip="$(jq -r '.ip' <<< "$exit_ip_json")"
    printf '%s (%s, %s)\n' "$ip" "$city" "$country"
}
alias torexit='tor_exit_node_ip'

function toggle_tor_exit_node() {
    # toggle between standard multi-country_exit-node and French_exit-node-only settings
    #sudo sed -i 
    :
}

# find where my own external IP's exit node is located
# display plain unproxied ip
#alias ipinfo1='ipinfo="$(wget http://ipinfo.io/ip -qO -)" echo -e "${ipinfo}\n"'
#alias ipinfo1='ipinfo=$(wget http://ipinfo.io/ip -qO -); echo "$ipinfo"'
#alias ipinfo1='echo $(wget http://ipinfo.io/ip -qO -)'
alias ipinfo1='curl -s ipinfo.io/json; printf "\n"'
alias ipinfo2='curl -s checkip.dyndns.org | sed -e "s/.*Current IP Address: //" -e "s/<.*$//"'
alias ipinfo3='curl -s ifconfig.co'   # also: 'ifonfig.co/json', 'ifconfig.co/country'
alias ipinfo4='curl -4 icanhazip.com'
alias ipinfo5='curl ipinfo.io/"$(curl -s icanhazip.com)"; printf "\n"'

# DNS lookup(forward and reverse)
alias dnslookup='dig +short -p 53 @8.8.8.8 '
alias revdnslookup='dig +short -p 53 @8.8.8.8 -x '

# display network interface card's MAC
function nic_mac_address () {
    awk '{print $2,$(NF-2)}' <(ip -o link)
}
alias nicmac='nic_mac_address'

# quickly list all TCP/UDP ports on $HOST
alias portinfo='netstat -tulanp'
                # -t for "tcp" port
                # -u for "udp" port
                # -l for "listening" port
                # -a for "all"
                # -n for "numeric"
                # -p for "program"

function expandurl() {
    # expands shortened url
    [ $# != 1 ] && printf "\nPlease provide exactly one URL as argument.\n\n" && return
    curl -sIL "$1" | grep ^Location
}

function iswebup() {
    # details whether given web site is up and running
    [ $# != 1 ] && printf "\nPlease provide exactly one web site as argument.\n\n" && return
    curl --head -s "$1" -L | grep HTTP/
}
#    1}}}

# Gadgets    {{{1
function weather() {
    # prints weather forecast in plain text on screen
    [ $# != 1 ] && printf "\nPlease provide exactly one city name as argument.\n\n" && return
    curl wttr.in/"$1"
}

alias worldmap='telnet mapscii.me'
#    1}}}

# Backup (rsync)    {{{1
function bckitup () {
    # backs up specific volumes and files to external SSD when mounted
    sudo /opt/scripts/runoncedaily.sh ckb last_bu /opt/scripts/bckitup.sh
}
#   1}}}

# =====================================================================

# PACKAGE/ENVIRONMENT SPECIFIC SHORTCUTS AND FUNCTIONS   {{{1

# =============================
# TMUX   {{{2
alias gtmux='~/.tmux/gnome-term-session.sh'
#   2}}}

# =============================
# GITHUB    {{{2
# staging function
function gitsta() {
    case $1 in
        -[aA]|-[aA][lL][lL])
            git add -u     # Update the index just where entry matching <pathspec> exists
                           # If no <pathspec> is given, all tracked files in the entire working
                           # tree are updated
            git add -- *   # option '--' is used to seperate cmd-line options from list of files
                           # '*' considers adding content of all files in working tree
            for file in .[^.]*; do git add -- "$file"; done
            ;;
        *)
            git add "$@"  # add file(s) specified as argument(s)
            ;;
    esac
}

# commit function
function gitcom() {
    # "$*" makes all arguments as one when quoted
    git commit -m  "$*"
}
function gitloglast() {
    for branch in $(git branch -r | grep -v HEAD); do
        # 'branch' name cannot contain space
        echo -e "$(git show --format="%ci %cr" "$branch" | head -n 1)" \\t"${branch}"
    done | sort -r
}

#alias gitlog='git log --pretty=format:"%>(9)%Cgreen%h%Creset: Author: %Cblue%an%Creset | Committer: %Cblue%cn%Creset | Time: %ad%n         Commit note: %s" --graph --date=format:"%Y-%M-%d %H:%m:%S"'
# Show git log with commit time-stamp and note
alias gitlog='git log --all --full-history --color --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd)%Creset A:%C(bold blue)<%an>%Creset C:%C(bold blue)<%cn>%Creset" --abbrev-commit --date=format:"%Y%m%d-%H:%M"'
#alias gitlog='git log --pretty=format:"%Cgreen%h%Creset: Author: %Cblue%an%Creset | Committer: %Cblue%cn%Creset | Commit time: %cd%n         Commit note: %s" --graph --date=format:"%Y%m%d %H%M%S"'
#alias gitlog='git log --color=always --pretty=format:"%h: %an-%cn %cr: %s" --graph | less -WN'
#     2}}}

# =============================
# TRIPWIRE    {{{2
# build and sign tw.cfg info coreutils 'groups invocation'
#alias twcfgbld='path="/mnt/TW_db-bin"; sudo twadmin -m F -c "${path}"/tw.cfg -S "${path}"/site.key "${path}"/twcfg.txt'
# build and sign tw.pol
#alias twpolbld='path="/mnt/TW_db-bin"; sudo twadmin -m P -c "${path}"/tw.cfg -p "${path}"/tw.pol -S "${path}"/site.key "${path}"/twpol.txt'
# initiate db w/ new tw.cfg and/or tw.pol files
#alias twdbbld='path="/mnt/TW_db-bin"; sudo ${path}/tripwire -m i -c /tw.cfg -p ${path}/mnt/TW_db-bin/tw.pol -S ${path}/site.key -L ${path}/${HOSTNAME}-local.key -d ${path}/${HOSTNAME}.twd'
#alias twiic='sudo bash -c '\''nowdir="$PWD"; path="/mnt/TW_db-bin"; cd "${path}"; tripwire -m c -c "${path}"/tw.cfg -I; cd "$nowdir"\''
# alias twdbupd='nowdir=$(pwd);cd /mnt/TW_db-bin/report; lastrpt=$(/bin/ls -1 *.twr | /usr/bin/tail -1); sudo tripwire -m u -a -c /mnt/TW_db-bin/tw.cfg -p /mnt/TW_db-bin/tw.pol -S /mnt/TW_db-bin/site.key -L /mnt/TW_db-bin/${HOSTNAME}-local.key -d /mnt/TW_db-bin/${HOSTNAME}.twd -r ${lastrpt}; cd $nowdir'  # automatic update db
#    2}}}

# =============================
# AWS    {{{2
sshaws() {
    printf "Connect to AWS instance %s@%s" "$1,$2\\n"
    ssh -i "$3" "$1"@"$2"
    # For UPC/FIB/MIRI/DS projecti use:
    #   $1: "ubuntu"
    #   $2: internet domain
    #   $3: "~/Documents/Academic/UPC/MIRI/Subjetcs/DS_decentralized-systems/Project/upcfib_ds.pem"
}
#
# CLI ENVIRONMENT VARIABLES
# test for the existence of ~/.aws/{config,credentials} files, before
# export of AWS env variables
if [ -f "$HOME"/.aws/credentials ]; then
    parsefile="$HOME"/.aws/credentials
    AWS_ACCESS_KEY_ID=$(awk '/aws_access_key_id/ {print $3}' "$parsefile")
    export AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY=$(awk '/aws_secret_access_key/ {print $3}' "$parsefile")
    export AWS_SECRET_ACCESS_KEY
fi
if [ -f "$HOME"/.aws/config ]; then
    parsefile="$HOME"/.aws/config
    AWS_DEFAULT_REGION=$(awk '/region/ {print $3}' "$parsefile")
    export AWS_DEFAULT_REGION
fi

# set up cmd completion for AWS CLI
#complete -C '/home/ckb/anaconda2/bin/aws_completer' aws

#    2}}}

# =============================
# ARCH LINUX   {{{2
alias aurvote='ssh aur@aur.archlinux.org vote'
alias ifplugd='sudo systemctl start netctl-ifplugd@net0'
alias bscvpn='sudo openfortivpn gw.bsc.es:443 -u cbhihe'
#alias bscvpn='fortivpn connect bscvpn --user=cbhihe --password'   # requires license activation
alias upcvpn='sudo /usr/bin/openvpn --config /etc/openvpn/vpn.upc-fib-access.ovpn'
alias basetisvpn='sudo /usr/bin/openvpn --config /etc/openvpn/vpn.basetis-pedrera.ovpn'
alias kubikawsbastion='ssh -i ca.pem/aws_kubikprivatekey.pem basetis@proxy.kubikdata.online'
alias upcssh='ssh bhihe@arvei.ac.upc.edu' # passwd: [usual_upc]
alias paccacheclean='paccache -rk2'  # add '-u' to remove only uninstalled packages
alias pacorphanclean='sudo pacman -Rns $(pacman -Qtdq)' # orphans' + conf files' recursive removal
#    2}}}

# =============================
# PYTHON    {{{2
alias pythonpath='python -c "import sys; print('\''\n'\''.join(sys.path))"'
alias pipshow='python -m pip show'

# VENV
alias vpython='python3 -m venv --system-site-packages --prompt VENV'
#alias vpython='python3 -m venv --without-pip --system-site-packages --prompt VENV'

#   2}}}

# =============================
# UDEV   {{{2
alias reloadudev='sudo udevadm control --reload-rules'
alias triggerudev='sudo udevadm trigger'
#    2}}}

# =============================
# DEBIAN-BASED LINUX    {{{2

# alias setswap='printf "%s" "Current session swappiness set to: "; sudo sysctl vm.swappiness=$1'

# apt-get shortcuts
#alias sac='sudo apt-cache'           # shortcut followed by 'show','showpkg'
                                     # 'search','pkgnames',
#alias sacs='sudo apt-cache stats'    # shows overall statistics of cache
#alias sacd='sudo apt-cache depends'  # shows dependencies
#alias sacr='sudo apt-cache rdepends' # shows reverse dependencies
#alias sacp='sudo apt-cache policy'   # prints out priorities of each source
                                     #+ (no arg) || prints out info on
                                     #+ priority selection of named package.
#alias sag='sudo apt-get'
#alias sagu='sudo apt-get update'
#alias sagy='sudo apt-get --yes'
#alias suuc='sudo apt-get update; sudo apt-get dist-upgrade; sudo apt-get \
#   upgrade; sudo apt-get clean; sudo apt-get autoremove'
#alias sagc='sudo apt-get check'      # diagnoses broken dependencies
#alias saga='sudo apt-get autoclean'  # deletes all .deb files from
                                     # /var/cache/apt/archives to free MB.
#alias sagr='sudo apt-get autoremove' # removes package with all dependencies
                                     # provided they aren't used anymore
#alias saar='sudo add-apt repository' # adds repo

#alias hwinfo='sudo lshw -html -numeric -sanitize >/Backups/hw-profile.html; \
#    printf "%s\n" "Sanitized hardware profile in html file:///Backups/hw-profile.html"'


## Display all manually installed packages since last fresh install
## Modified from http://askubuntu.com -- question 2389
#function mipinfo1 () {
#   datestp="$(/bin/date +\%Y\%m\%d-\%H\%M\%S)"
#    ofile="/Backups/mpi1_$datestp"
#    printf "%s\n" "-- Results kept in $ofile"
#    printf "%s\n" "======  Manually installed packages  ======" > "$ofile"
#    printf "%s\n\n" "as of $datestp" > "$ofile"
#    comm -23 <(apt-mark showmanual | sort -u) \
#       <(gzip -dc /var/log/installer/initial-status.gz \
#       | sed -n 's/^Package: //p' | sort -u) \
#       >> "$ofile"
#}
#alias mpi1="mipinfo1"

## Diplay all manually installed packages since last fresh install
## Modified from http://serverfault.com -- question 175504
#function mipinfo2 ()
#{
#   datestp="$(/bin/date +\%Y\%m\%d-\%H\%M\%S)"
#    ofile="/Backups/mpi2_$datestp"
#    printf "%s\n" "-- Results kept in $ofile"
#    printf "%s\n" "======  Manually installed packages  ======" > "$ofile"
#    printf "%s\n\n" "as of $datestp" > "$ofile"
#    comm -23 <(dpkg --get-selections | sed -n 's/\t\+install$//p' | sort) \
#         <(</var/lib/apt/extended_states \
#           awk -v RS= '/\nAuto-Installed: *1/ {printi $2}' |sort) >> "$ofile"
#}
#alias mpi2="mipinfo2"
#    2}}}

# =============================
## UPC VPN connect / status / kill   {{{2
#alias upcvpn='/usr/local/pulse/PulseClient.sh -h vpn.upc.edu -u sedric.bhihe -r Estudiants -U https://vpn.upc.edu'
#alias upcvpnstat='/usr/local/pulse/PulseClient.sh -S'
#alias upcvpnkill='/usr/local/pulse/PulseClient.sh -K'
#    2}}}
#    1}}}

