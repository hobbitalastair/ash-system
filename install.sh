#!/usr/bin/sh
################################################################################
# Desktop install script
#
# - Add a patch for xinitrc
#
# Last modified: 7-6-2014
#
################################################################################

post_upgrade () {

    ASH_DESKTOP_PATCHDIR="/usr/share/ash-desktop"

    if [ $(vercmp $2 0.3-13) -lt 1 ]; then
        patchman -A "/etc/X11/xinit/xinitrc" \
                    "${ASH_DESKTOP_PATCHDIR}/xinitrc.file" --nocheck
    else
        patchman -U "/etc/X11/xinit/xinitrc" \
                    "${ASH_DESKTOP_PATCHDIR}/xinitrc.file" --nocheck
    fi

}
