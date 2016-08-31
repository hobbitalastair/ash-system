#! /usr/bin/sh
post_install() {
    # wpa_supplicant is installed readable by other by default...
    chmod o-r /etc/wpa_supplicant/wpa_supplicant.conf
}
