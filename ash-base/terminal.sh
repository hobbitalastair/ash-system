# Add my own colors
[ -r "${XDG_CONFIG_HOME}/dircolours.conf" ] && \
    eval $(dircolors --sh "${XDG_CONFIG_HOME}/dircolours.conf")

# Load any personal config
if [ -r "${XDG_CONFIG_HOME}/profile" ]; then
    . "${XDG_CONFIG_HOME}/profile"
fi

# Prompt
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
