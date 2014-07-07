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

# Main application aliases
alias lynx="lynx -book -accept_all_cookies"
alias vim="vim -u /etc/vim.conf -i $XDG_DATA_HOME/vim.info"
alias unison="unison -logfile ${XDG_CACHE_HOME}/unison.log"
alias pylint="pylint --rcfile=/etc/pylint.config"


#
# Environment variables
#

export EDITOR="/usr/bin/vim"
export BROWSER="/usr/bin/lynx"
export PAGER="/usr/bin/less"

# Application environment variables
export TZ='Pacific/Auckland'
export HISTFILE="$XDG_DATA_HOME/bash.history"
export LESSHISTFILE="$XDG_DATA_HOME/less.history"

#export PYTHONPATH="$HOME/python/apg"
export PYTHONDONTWRITEBYTECODE="True"
export UNISON="$XDG_CONFIG_HOME/unison"
export UNISONBACKUPDIR="$XDG_DATA_HOME/unison/backups"
export GIT_DIR=".git"


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
eval $(keychain --eval --dir ${XDG_CONFIG_HOME}/keychain --agents ssh -Q -q \
        id_rsa)

