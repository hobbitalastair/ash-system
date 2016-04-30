#! /usr/bin/sh
###############################################################################
# Install script for the various base services
#
# - Add the ash user
# - Symlink in NZ as the timezone
# - Locale generation
# - Password setting for root and ash
# - Add an ssh key
# - Manage the hostnames
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
        useradd ash -G video -c "Alastair Hughes" -U && \
            echo "   Added user 'ash'" || echo "-> Failed to add user 'ash'!"
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

    # Does not work from a live cd - why?

    # Generate an ssh key for ash
    #echo "-> Generating a ssh key for ash"
    #ssh-keygen -t rsa -C "hobbitalastair@yandex.com"

    # Copy the ssh key to 'control'
    # Make sure this happens or else you will be locked out!!!
    #ssh-copy-id ash@control.localdomain && \
    #    echo "   Copied the ssh key to 'control'" ||
    #    echo "-> Failed to copy the ssh key to 'control'!!!" && exit 2
    # Copy in the other direction
    #ssh ash@control.localdomain -c "ssh-copy-id ash@$(hostname)" && \
    #    echo "   Key copied from control to $(hostname)" ||
    #    echo "-> Failed to copy the ssh key from control to $(hostname)" && \
    #        exit 2
    
    # Reminder to generate a mkinitcpio and add a bootloader, if on a pc
    if [ $(uname -m | grep 86) ]; then
        echo ":: Reminder: Modify /etc/mkinitcpio.conf then regenerate a " \
             "initcpio "
        echo "   with 'mkinitcpio -p linux"
        echo ":: Reminder: Add a bootloader!"
    fi

    # Get the new hostname and pretty hostname
    echo "-> Please enter a new hostname: "
    read HOSTNAME
    hostnamectl --static $HOSTNAME
    echo "-> Please enter a new pretty hostname: "
    read PRETTY_HOSTNAME
    hostnamectl --pretty $PRETTY_HOSTNAME

    echo ":: Reminder: Please add the hostname $HOSTNAME to the static " \
         "hostname file"

    # Patches
    patchman -A "/etc/hosts" "${PATCHDIR}/hosts.file" --nocheck && \
        echo '   Patched /etc/hosts' || \
        echo '-> Patching /etc/hosts failed!'

    patchman -A "/etc/ssh/sshd_config" "${PATCHDIR}/sshd_config.sed" \
        --nocheck && \
        echo "   Patched /etc/ssh/sshd_config" || \
        echo "-> Patching /etc/ssh/sshd_config failed!"

    PATCH='pacman.conf.sh'
    TARGET='/etc/pacman.conf'
    patchman -A "$TARGET" "${PATCHDIR}/$PATCH" \
        --nocheck && \
        echo "   Patched $TARGET" || \
        echo "-> Patching $TARGET failed!"

    # Bashrc patch
    PATCH='bash.bashrc.file'
    TARGET='/etc/bash.bashrc'
    patchman -A "$TARGET" "${PATCHDIR}/$PATCH" \
        --nocheck && \
        echo "   Patched $TARGET" || \
        echo "-> Patching $TARGET failed!"
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

    # Hostnames patch (TODO: Implement a DNS server)
    if [ $(vercmp $2 0.2.4) -lt 1 ]; then
        patchman -A "/etc/hosts" "${PATCHDIR}/hosts.file" --nocheck && \
            echo "   Patched /etc/hosts" || \
            echo "-> Patching /etc/hosts failed!"
    else
        patchman -U "/etc/hosts" "${PATCHDIR}/hosts.file" --nocheck
    fi

    # SSH config patch
    if [ $(vercmp $2 0.2.10) -lt 1 ]; then
        patchman -A "/etc/ssh/sshd_config" "${PATCHDIR}/sshd_config.sed" \
            --nocheck && \
            echo "   Patched /etc/ssh/sshd_config" || \
            echo "-> Patching /etc/ssh/sshd_config failed!"
    else
        patchman -U "/etc/ssh/sshd_config" "${PATCHDIR}/sshd_config.sed" \
            --nocheck
    fi
    # Restart sshd
    systemctl restart sshd

    # Environment patch
    if [ $(vercmp $2 0.2.12) -lt 1 ]; then
        patchman -A "/etc/environment" "${PATCHDIR}/environment.file" \
            --nocheck && \
            echo "   Patched /etc/environment" || \
            echo "-> Patching /etc/environment failed!"
    else
        patchman -U "/etc/environment" "${PATCHDIR}/environment.file" \
            --nocheck
    fi

    # Pacman conf patch
    PATCH='pacman.conf.sh'
    TARGET='/etc/pacman.conf'
    VERSION=0.2.14
    if [ $(vercmp $2 $VERSION) -lt 1 ]; then
        patchman -A "$TARGET" "${PATCHDIR}/$PATCH" \
            --nocheck && \
            echo "   Patched $TARGET" || \
            echo "-> Patching $TARGET failed!"
    else
        patchman -U "$TARGET" "${PATCHDIR}/$PATCH" \
            --nocheck
    fi

    # Bashrc patch
    PATCH='bash.bashrc.file'
    TARGET='/etc/bash.bashrc'
    VERSION=0.2.20
    if [ $(vercmp $2 $VERSION) -lt 1 ]; then
        patchman -A "$TARGET" "${PATCHDIR}/$PATCH" \
            --nocheck && \
            echo "   Patched $TARGET" || \
            echo "-> Patching $TARGET failed!"
    else
        patchman -U "$TARGET" "${PATCHDIR}/$PATCH" \
            --nocheck
    fi

    # Bashrc patch
    PATCH='lynx.cfg.patch'
    TARGET='/etc/lynx.cfg'
    VERSION=0.2.32
    if [ $(vercmp $2 $VERSION) -lt 1 ]; then
        patchman -R "$TARGET" "${PATCHDIR}/$PATCH" \
            --nocheck && \
            echo '   Unpatched /etc/lynx.cfg' || \
            echo '-> Unpatching /etc/lynx.cfg failed!'
    fi
}

# arg 1:  the old package version
pre_remove() {
    echo "-> Cleaning up ash-base"
    # Remove ash
    userdel ash && \
        echo "   User 'ash' removed" || echo "-> Failed to delete user 'ash'"

    # Remove the timezone symlink
    rm /etc/localtime && \
        echo "   Removed timezone symlink" || \
        echo "-> Failed to remove timezone symlink!"

    # Remove locale.conf and recomment /etc/locale.gen
    rm /etc/locale.conf && \
        echo "   Removed /etc/locale.conf" || \
        echo "-> Failed to remove /etc/locale.conf!"
    sed -i -e "s:$NEW_LANG UTF-8:#$NEW_LANG UTF-8:" /etc/locale.gen && \
        echo "   Recommented $NEW_LANG in /etc/locale.gen" || \
        echo "-> Failed to recomment $NEW_LANG in /etc/locale.gen"

    # Removing the patches
    patchman -R "/etc/hosts" "${PATCHDIR}/hosts.file" --nocheck && \
        echo '   Unpatched /etc/hosts' || \
        echo '-> Unpatching /etc/hosts failed!'

    patchman -R "/etc/ssh/sshd_config" "${PATCHDIR}/sshd_config.sed" \
        --nocheck && \
        echo "   Unpatched /etc/ssh/sshd_config" || \
        echo "-> Unpatching /etc/ssh/sshd_config failed!"

    PATCH='pacman.conf.sh'
    TARGET='/etc/pacman.conf'
    patchman -R "$TARGET" "${PATCHDIR}/$PATCH" \
        --nocheck && \
        echo "   Unpatched $TARGET" || \
        echo "-> Unpatching $TARGET failed!"

    # Bashrc patch
    PATCH='bash.bashrc.file'
    TARGET='/etc/bash.bashrc'
    patchman -R "$TARGET" "${PATCHDIR}/$PATCH" \
        --nocheck && \
        echo "   Unpatched $TARGET" || \
        echo "-> Unpatching $TARGET failed!"
}

