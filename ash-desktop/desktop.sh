# Shell variables and aliases for the ash-desktop package

# X auth file location
# Don't use XDG_CACHE_HOME because, depending on the profile load order,
# it may not have been exported yet (!)
export XAUTHORITY="${HOME}/.cache/xauthority"

alias startx="startx ~/.config/xinit.conf"
