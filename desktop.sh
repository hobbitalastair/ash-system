# Shell variables and aliases for the ash-desktop package

# Fvwm config location
# Here to create a global config, rather than 1 for each directory
export FVWM_USERDIR="/etc/fvwm"
# Wallpaper location - overwrite in .profile files as required
export FVWM_DESKTOP="/usr/share/ash-desktop/images/arch_wallpaper.png"

# X auth file location
# Dont use XDG_CACHE_HOME because, depending on the profile load order,
# it may not have been exported yet (!)
#TODO: Fix - how?
export XAUTHORITY="${HOME}/.cache/xauthority"
