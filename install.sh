#!/usr/bin/sh

force_update() {
    patchman.sh -r /etc/bash.bashrc
    patchman.sh -r /etc/hosts
    patchman.sh -r /etc/ssh/sshd_config
}

post_install() {
    force_update
}

post_upgrade() {
    force_update
}
