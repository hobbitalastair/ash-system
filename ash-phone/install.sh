#!/usr/bin/env sh

force_update() {
    patchman.sh -r /etc/ppp/pap-secrets
}

post_install() {
    force_update
}

post_upgrade() {
    force_update
}
