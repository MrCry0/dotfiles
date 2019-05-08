#############################################
# ##### SANDSMARK'S hobbgobble bashrc ##### #
#############################################
# ##### COPYBLEH 2010 ##### #
#############################

#########
# general

umask 022

###############
# env variables

declare -x PATH="/usr/local/bin/:~/go/bin/:$PATH"

declare -x LS_COLORS='no=01;37:fi=01;37:di=01;34:ln=01;36:pi=01;32:so=01;35:do=01;35:bd=01;33:cd=01;33:ex=01;31:mi=00;37:or=00;36:'

declare -x PAGER='less'

declare -x EDITOR='vim'
declare -x TERM='xterm-256color'

declare -x VISUAL="${EDITOR}"
declare -x FCEDIT="${EDITOR}"

declare -x PROMPT_COMMAND='ret=$?; if [ $ret -ne 0 ] ; then echo -e "returned \033[01;31m$ret\033[00;00m"; fi; history -a'

declare -x HISTFILE=~/.bash_history
declare -x HISTCONTROL=ignoreboth:erasedups
declare -x HISTSIZE=-1

declare -x BROWSER=chromium

declare -x CCACHE_PATH="/usr/bin"
declare -x GCC_COLORS=auto

declare -x MALLOC_CHECK_=1

declare -x BC_ENV_ARGS=~/.bcrc

declare -x WINEARCH="win32"

declare -x QT_NO_GLIB=1

declare -x QTC_HELPVIEWER_BACKEND=textbrowser

declare -x QT_AUTO_SCREEN_SCALE_FACTOR=0

declare -x QTKEYCHAIN_BACKEND=kwallet5

declare -x QT_QPA_PLATFORMTHEME=sandsmark

declare -x LSAN_OPTIONS=suppressions=${HOME}/.lsan.suppressions

declare -x LIBVA_DRIVER_NAME=iHD
declare -x VDPAU_DRIVER=va_gl


#################
# shell variables

set -o noclobber
set -o physical

shopt -s cdspell
shopt -s extglob
shopt -s dotglob
shopt -s cmdhist
shopt -s lithist
shopt -s progcomp
shopt -s checkhash
shopt -s histreedit
shopt -s histappend
shopt -s promptvars
shopt -s cdable_vars
shopt -s checkwinsize
shopt -s hostcomplete
shopt -s expand_aliases
shopt -s interactive_comments

#########
# aliases

alias vi=vim
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias l=ls
alias ll='ls -l'
alias feh='feh -.'
alias sprunge="curl -F 'sprunge=<-' http://sprunge.us"
alias ix="curl -n -F 'f:1=<-' http://ix.io"

###########
# functions

function x     { exit    $@; }
function z     { suspend $@; }
function j     { jobs -l $@; }

function p     { ${PAGER}  $@; }
function e     { ${EDITOR} $@; }

function c     { clear; }
function h     { history $@; }
function hc    { history -c; }
function hcc   { hc;c; }

function cx    { hc;x; }

function ..    { cd ..; }

function ll    { ls --color=auto -FAql $@; }
function lf    { ls --color=auto -FAq  $@; }

function make    { ionice nice make $@; }

function ff    { find . -name $@; }

function dmsg  { dmesg | p; }

# function cd    { builtin cd "$@" && ls; }

function mkcd    { mkdir "$@" && builtin cd "$@"; }

function h2d    { echo "ibase=16; $@"|bc; }
function h2b    { echo "ibase=16;obase=2; $(echo $@ | tr [:lower:] [:upper:])" |bc; }
function b2h    { echo "ibase=2;obase=16; $@"|bc; }
function d2h    { echo "obase=16; $@"|bc; }

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function mac-vendor {
    MAC="$(echo $@ | sed 's/ //g' | sed 's/-//g' | sed 's/://g' | cut -c1-6)";

    result="$(grep -i -A 4 ^$MAC ~/oui.txt)";

    if [ "$result" ]; then
        echo "For the MAC $1 the following information is found:"
        echo "$result"
    else
        echo "MAC $1 is not found in the database."
    fi

}

function vim    {
    if [[ "$@" =~ (.*):([0-9]+) ]]; then
        /usr/bin/vim +"${BASH_REMATCH[2]}" "${BASH_REMATCH[1]}"
    else
        /usr/bin/vim "$@"
    fi
}

export ELIDED_PATH='$(echo -n "${PWD/#$HOME/\~}" | awk -F "/" '"'"'{
if (length($0) > 50) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
else if (NF>3) print $1 "/" $2 "/.../" $NF;
else print $1 "/.../" $NF; }
else print $0;}'"'"')'

#############
# completions

# complete -W '$(echo $(cut -d\  -f1 < ~/.ssh/known_hosts | cut -d, -f1))' mosh

# git prompt
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#        color_prompt=yes
#    else
#        color_prompt=
#    fi
# fi

########
# prompt

if [ `id -u` -eq 0 ]
then
    txtusr="${txtred}"
else
    txtusr="${txtgrn}"
fi

if [ "$color_prompt" = yes ]; then
    export PS1="\${debian_chroot:+(\$debian_chroot)}\[$txtusr\]\u@\h\[$txtrst\]:\[$txtblu\]\w\[$txtrst\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

else
    export PS1="\${debian_chroot:+(\$debian_chroot)}\u@\h:\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

fi
