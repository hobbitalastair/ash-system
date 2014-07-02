#! /usr/bin/sh
###############################################################################
# Install script for the various base services
#
# - Enable syslog-ng
# - Enable cron
# - Enable ntp
# - Enable dhcpcd
# - Add the ash user
# - Symlink in NZ as the timezone
# - Locale generation
# - Password setting for root and ash
# - Patches for various files
# 
#
# Uninstalling should reverse everything.
# The ash home dir will be kept, however
#
# Last modified: 8-6-2014
#
###############################################################################

export TIMEZONE="Pacific/Auckland"
export NEW_LANG="en_NZ.UTF-8"

# Dir where the patches are stored
PATCHDIR="/usr/share/ash-base"

# arg 1:  the new package version
post_install() {
    echo "-> Setting up the base system with a TZ of $TIMEZONE and a "\
            "lang of $NEW_LANG"
    # Add the ash user
    # First, check wether the user already exists
    if [ $(cat /etc/passwd | grep -e ^ash) ]; then
        echo "   User ash exists - leaving"
    else
        useradd ash -m -G video -c "Alastair Hughes" -U && \
            echo "   Added user 'ash'" || echo "-> Failed to add user 'ash'!"
        # Update permissions on /home/ash
        chown ash -R /home/ash && chgrp ash -R /home/ash ||
            echo "-> Failed to update permissions on /home/ash!"
    fi

    # Symlink in the timezone
    ln -s /usr/share/zoneinfo/$TIMEZONE /etc/localtime && \
        echo "   Set the timezone to $TIMEZONE" || \
        echo "-> Failed to set the timezone via symlinking!"

    # Generate the locale
    # Change locale.gen using sed. This file is pacman managed.
    sed -i -e "s:#$NEW_LANG UTF-8:$NEW_LANG UTF-8:" /etc/locale.gen && \
    locale-gen && \
        echo "   Locale set in /etc/locale.gen and generated" || \
        echo "-> Failed to set locale in /etc/locale.gen and generate it!"
    # Set the locale config.
    # This file is not managed or created by pacman
    echo "LANG=$NEW_LANG" > /etc/locale.conf && \
        echo "   Language set in /etc/locale.conf to $NEW_LANG" || \
        echo "-> Failed to set the language in /etc/locale.conf!"

    # Set the passwords
    echo "-> New root passwd:"
    passwd root
    echo "-> New ash passwd:"
    passwd ash
    
    # Enable ntp
    systemctl enable ntpd && \
        echo "   ntpd enabled" || echo "-> Failed to enble ntpd!"

    # Enable dhcpcd
    systemctl enable dhcpcd && \
        echo "   dhcpcd enabled" || echo "-> Failed to enable dhcpcd!"

    # Reminder to generate a mkinitcpio and add a bootloaded, if on a pc
    if [ $(uname -m | grep 86) ]; then
        echo ":: Reminder: Modify /etc/mkinitcpio.conf then regenerate a initcpio "
        echo "   with 'mkinitcpio -p linux"
        echo ":: Reminder: Add a bootloader!"
    fi

    # Patches
    patchman -A "/etc/lynx.cfg" "${PATCHDIR}/lynx.cfg.patch" --nocheck && \
        echo '   Patched /etc/lynx.cfg' || \
        echo '-> Patching /etc/lynx.cfg failed!'

    patchman -A "/etc/hosts" "${PATCHDIR}/hosts.file" --nocheck && \
        echo '   Patched /etc/hosts' || \
        echo '-> Patching /etc/hosts failed!'

}

## arg 1:  the new package version
## arg 2:  the old package version
pre_upgrade() {
    # Remove the old hostnames patch
    if [ $(vercmp $2 0.2.4) -lt 1 ]; then
        patchman -R "/etc/hosts" "${PATCHDIR}/hosts.patch" --nocheck && \
            echo '   Unpatched /etc/hosts' || \
            echo '-> Unpatching /etc/hosts failed!'
    fi
}

## arg 1:  the new package version
## arg 2:  the old package version
post_upgrade() {

    # Lynx config patch
    if [ $(vercmp $2 0.1-14) -lt 1 ]; then
        patchman -A "/etc/lynx.cfg" "${PATCHDIR}/lynx.cfg.patch" --nocheck && \
            echo '   Patched /etc/lynx.cfg' || \
            echo '-> Patching /etc/lynx.cfg failed!'
    else
        patchman -U "/etc/lynx.cfg" "${PATCHDIR}/lynx.cfg.patch" --nocheck
    fi

    # Hostnames patch (TODO: Implement a DNS server)
    if [ $(vercmp $2 0.2.4) -lt 1 ]; then
        patchman -A "/etc/hosts" "${PATCHDIR}/hosts.file" --nocheck && \
            echo "   Patched /etc/hosts" || \
            echo "-> Patching /etc/hosts failed!"
    else
        patchman -U "/etc/hosts" "${PATCHDIR}/hosts.file" --nocheck
    fi

}

# arg 1:  the old package version
pre_remove() {
    echo "-> Cleaning up ash-base"
    # Remove ash
    userdel ash && \
        echo "   User 'ash' removed" || echo "-> Failed to delete user 'ash'"

    # Disable ntp
    systemctl disable ntpd && \
        echo "   ntpd disabled" || echo "-> Failed to disable ntpd!"

    # Disable dhcpcd
    systemctl disable dhcpcd && \
        echo "   dhcpcd disabled" || echo "-> Failed to disable dhcpcd!"

    # Remove the timezone symlink
    rm /etc/localtime && \
        echo "   Removed timezone symlink" || echo "-> Failed to remove timezone symlink!"

    # Remove locale.conf and recomment /etc/locale.gen
    rm /etc/locale.conf && \
        echo "   Removed /etc/locale.conf" || echo "-> Failed to remove /etc/locale.conf!"
    sed -i -e "s:$NEW_LANG UTF-8:#$NEW_LANG UTF-8:" /etc/locale.gen && \
        echo "   Recommented $NEW_LANG in /etc/locale.gen" || \
        echo "-> Failed to recomment $NEW_LANG in /etc/locale.gen"

    # Removing the patches
    patchman -R "/etc/lynx.cfg" "${PATCHDIR}/lynx.cfg.patch" --nocheck && \
        echo '   Unpatched /etc/lynx.cfg' || \
        echo '-> Unpatching /etc/lynx.cfg failed!'

    patchman -R "/etc/hosts" "${PATCHDIR}/hosts.file" --nocheck && \
        echo '   Unpatched /etc/hosts' || \
        echo '-> Unpatching /etc/hosts failed!'

}

