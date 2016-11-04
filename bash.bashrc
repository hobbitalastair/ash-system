#
# /etc/bash.bashrc
#

# Source the local bash config.
[ -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bash.conf" ] && \
    . "${XDG_CONFIG_HOME:-$HOME/.config}/bash/bash.conf"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
