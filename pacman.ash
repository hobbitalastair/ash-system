# This is my personal pacman file for controlling my packages, without having
# to extensively edit /etc/pacman.conf itself.

#
# Config
#

[options]
# Color!
Color

# Check for space first...
CheckSpace

# Download 'diffs' instead of whole packages
UseDelta

# Use verbose package lists
VerbosePkgLists


#
# Repos
#

[custom]
Server = http://control/
SigLevel = Optional TrustAll

