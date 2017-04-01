force_update() {
    patchman.sh -r /etc/papersize
}

post_install() {
    force_update
}

post_upgrade() {
    force_update
}
