# Terminal profile file
# Author: Alastair Hughes <hobbitalastair at yandex dot com>

#
# Base directory specifications
#

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"


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
alias vim="vim -u /etc/vim.conf -i $XDG_DATA_HOME/vim.info"
alias unison="unison -logfile ${XDG_CACHE_HOME}/unison.log"
alias pylint="pylint --rcfile=/etc/pylint.config"
alias pacman="pacman --color=always"
alias dmesg="dmesg -H --color=always"


#
# Environment variables
#

# Application environment variables
export HISTFILE="$XDG_DATA_HOME/bash.history"
export LESSHISTFILE="$XDG_DATA_HOME/less.history"

export UNISON="$XDG_CONFIG_HOME/unison"
export UNISONBACKUPDIR="$XDG_DATA_HOME/unison/backups"


#
# Functions
#

ps_memory () {
    # Output the process's memory use (from ps)
    ps -v | grep -e "$1"
}

error_codes () {
    # Output a list of error codes, searched with $1 is supplied
    # Taken from online

    if ! [ "$1" ]; then
        ERROR_CODE=".*"
    else
        ERROR_CODE="$1"
    fi

    perl -e 'print grep !/unknown error/i, map $_." ".($!=$_).$/, 0..127' | \
        grep -e "^$ERROR_CODE "
}

#
# Programs
#

# Start the keychain
# Cannot do this in an alias - ssh is not called by git...
eval $(keychain --eval --dir ${XDG_CONFIG_HOME}/keychain --agents ssh -Q -q \
        id_rsa)

# Add my own colors
eval $(dircolors --sh /etc/dircolours.conf)


#
# Prompt...
#

get_prompt () {
    # Print out a prompt

    LAST_CMD=$?

    # Setup the user colour
    if [ "$(whoami)" == "root" ]; then
        user_colour='41;30' # Set the background to red
    elif [ "$(whoami)" != "$(basename $HOME)" ]; then
        user_colour=31 # Set user to be red
    else
        user_colour='34;01' # Set the user to blue
    fi

    USER="\033[${user_colour}m$(whoami)\033[00m"

    if [ "${LAST_CMD}" = 0 ]; then
        PR="\033[36m\$"
    else
        PR="\033[31m${LAST_CMD} \$"
    fi

    echo -ne "${USER}\033[01m@\033[39;m$(hostname) \033[33m$(basename $(pwd))\033[00m ${PR}\033[00m "
}

export PS1='$(get_prompt)'
