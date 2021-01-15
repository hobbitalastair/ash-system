#
# Base directory specifications
#

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"


#
# Environment variables
#

export VISUAL="vim"
export EDITOR="${VISUAL}"

# Application environment variables
export HISTFILE="$XDG_DATA_HOME/bash.history"
export LESSHISTFILE="$XDG_DATA_HOME/less.history"

export INPUTRC="${XDG_CONFIG_HOME}/input.conf"

# Lynx config.
export LYNX_CFG="${XDG_CONFIG_HOME}/lynx.conf"

# Vim config.
export VIMINIT='source /etc/vim.conf'

# I sometimes have to use subversion...
export SUBVERSION_HOME="${XDG_CONFIG_HOME}/subversion"

# SSH workarounds.
export GIT_SSH_COMMAND="ssh -F '${XDG_CONFIG_HOME}/ssh/config'"

# GNUPG is used by pacman, among others.
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg/"

# Python will write a .python_history file; use the new startup program to
# avoid that. Also, don't write byte code...
export PYTHONSTARTUP="/etc/python/startup.py"
export PYTHONDONTWRITEBYTECODE="True"

# Wine needs an architecture and default prefix.
export WINEPREFIX="${XDG_DATA_HOME}/wine"
export WINEARCH="win32"

#
# Programs
#

# Add my own colors
[ -r "${XDG_CONFIG_HOME}/dircolours.conf" ] && \
    eval $(dircolors --sh "${XDG_CONFIG_HOME}/dircolours.conf")

# Load any personal config
if [ -r "${XDG_CONFIG_HOME}/profile" ]; then
    . "${XDG_CONFIG_HOME}/profile"
fi


#
# Prompt
#

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
