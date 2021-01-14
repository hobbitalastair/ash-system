#!/usr/bin/env sh

force_update() {
    patchman.sh -r /etc/pacman.conf
}

post_install() {
    force_update
}

post_upgrade() {
    force_update
}
