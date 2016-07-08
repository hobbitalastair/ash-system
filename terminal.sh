# Terminal profile file
# Author: Alastair Hughes <hobbitalastair at yandex dot com>

#
# Base directory specifications
#

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"


#
# Environment variables
#

# Application environment variables
export HISTFILE="$XDG_DATA_HOME/bash.history"
export LESSHISTFILE="$XDG_DATA_HOME/less.history"

export UNISON="$XDG_CONFIG_HOME/unison"
export UNISONBACKUPDIR="$XDG_DATA_HOME/unison/backups"

# Lynx config.
export LYNX_CFG="${XDG_CONFIG_HOME}/lynx.conf"

# Vim config.
export VIMINIT='source /etc/vim.conf'

# I sometimes have to use subversion...
export SUBVERSION_HOME="${XDG_CONFIG_HOME}/subversion"

# SSH workarounds.
export SSH_CONFIG="-F '${XDG_CONFIG_HOME}/ssh/config'"
export GIT_SSH_COMMAND="ssh ${SSH_CONFIG}"

# GNUPG is used by pacman, among others.
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg/"

# Python will write a .python_history file; use the new startup program to
# avoid that.
export PYTHONSTARTUP="/etc/python/startup.py"

#
# Program alias
#

# Common shell command aliass
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ls="ls --color"
alias less="less -FR" # Add colour support, and quitting if the output is short
alias grep="grep --color=always"
alias man="man --html"

# Main application aliases
alias lynx="lynx -book -accept_all_cookies"
alias unison="unison -logfile ${XDG_CACHE_HOME}/unison.log"
alias unison-2.40="unison-2.40 -logfile ${XDG_CACHE_HOME}/unison-2.40.log"
alias pylint="pylint --rcfile=/etc/pylint.config"
alias pacman="pacman --color=always"
alias dmesg="dmesg -H --color=always"
alias hunspell="hunspell -p ${XDG_DATA_HOME}/hunspell/${LANG}.dict"
alias snownews="snownews --update"
alias ssh="ssh ${SSH_CONFIG}"
alias scp="scp ${SSH_CONFIG}"


#
# Functions
#

ps_memory () {
    # Output the process's memory use (from ps)
    ps -v | grep -e "$1"
}


#
# Programs
#

# Start the keychain
# Cannot do this in an alias - ssh is not called by git...
keylist=""
for id in "${XDG_CONFIG_HOME}/ssh/"*.pub; do
    if [ -f "${id}" ]; then
        # We have a key file!
        keylist+=" ${id%.pub}"
    fi
done
eval "$(keychain --eval --dir "${XDG_CONFIG_HOME}/keychain" \
    --agents ssh -Q -q ${keylist})"

# Add my own colors
eval $(dircolors --sh /etc/dircolours.conf)

# Load any personal config
if [ -f "${XDG_CONFIG_HOME}/profile" ]; then
    . "${XDG_CONFIG_HOME}/profile"
fi


#
# Prompt...
#

# Only export the prompt if in an interactive shell
if [ -n "$PS1" ]; then
    if [ "$(whoami)" == "root" ]; then
        user_col='41;30' # Set the background to be red.
    else
        user_col='34;01' # Set the foreground to be blue.
    fi
    PS1="\[\033[${user_col}m\]\u\[\033[00;01m\]"
    unset user_col
    PS1+='@\[\033[39;m\]\h \[\033[33m\]\W\[\033[00m\] '
    PS1+='$(LAST="$?"
        if [ "${LAST}" -ne 0 ]; then
            printf "\[\033[31m\]%s " "${LAST}"
        else
            printf "\[\033[36m\]"
        fi)\$\[\033[00m\] '
    export PS1
fi
