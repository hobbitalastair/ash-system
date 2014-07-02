# Terminal profile file
# Author: Alastair Hughes <hobbitalastair at yandex dot com>

# Base directory specifications
export XDG_DATA_HOME="$HOME/.data"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Program alias
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias ls="ls --color"
# Main application aliases
alias less="less -FR" # Add colour support, and quitting if the output is short
alias lynx="lynx -book -accept_all_cookies"
alias vim="vim -u /etc/vim.conf -i $XDG_DATA_HOME/vim.info"
# Programming applications alias - Move?
alias pylint="pylint --rcfile=/etc/pylint.config"

# Environment variables
export EDITOR="/usr/bin/vim"
export BROWSER="/usr/bin/lynx"
export PAGER="/usr/bin/less"

# Application environment variables
export PYTHONPATH="$HOME/python/apg"
export PYTHONDONTWRITEBYTECODE="True"
export HISTFILE="$XDG_DATA_HOME/bash.history"
export LESSHISTFILE="$XDG_DATA_HOME/less.history"
export TZ='Pacific/Auckland'
export UNISON="$XDG_CONFIG_HOME/unison"

# Are these in the right place?
#TODO: Move to a non-terminal file?
export GIT_DIR=".git"

# Start the ssh agent
# This provides the keys for ssh connections using them (no password required)
eval $(ssh-agent -s) > /dev/null

