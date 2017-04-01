# Maintainer: Alastair Hughes <hobbitalastair at yandex dot com>

udev=("99-low_battery.rules" "98-ac_adaptor.rules" "90-sata_powersave.rules" \
    "90-pci_powersave.rules")
sysctl=("disable_nmi.conf" "dirty_writeback.conf" "laptop.conf")

pkgname="powersave"
pkgver=0.1
pkgrel=1
pkgdesc="Powersaving changes for laptops"
arch=('any')
url=""
license=('MIT')
depends=('udev')
backup=()
options=()
source=("audio_powersave.conf"
        "ac_adaptor")
source+=( ${udev[@]})
source+=( ${sysctl[@]})
md5sums=('cb42db022873c55cefca316349f13f2b'
         'e1e793a51e805a61d4ca726db04ad4e5'
         '67dcc71f4d9f8631d0a51fcb39ea4c92'
         '211b61d2644970fb95b9e7c68568f637'
         '6f4705d7a3a2e271b0c9b29387be1c09'
         'd2bf51d6f95ab61dd03de98e20912f23'
         '7658062f57bccfd5b3b040810b928acd'
         'c6515cc992ae373712b626a25f2b3fb5'
         '9afa8010305ba478f32b73142656f01f')

package() {
    cd "${srcdir}"

    # Audio powersaving.
    install -Dm0644 "audio_powersave.conf" \
        "${pkgdir}/usr/lib/modprobe.d/audio_powersave.conf"

    # Udev rules
    for rule in "${udev[@]}"; do
        install -Dm0644 "${rule}" "${pkgdir}/usr/lib/udev/rules.d/${rule}"
    done

    # Udev scripts
    for script in "ac_adaptor"; do
        install -Dm0744 "${script}" "${pkgdir}/usr/lib/udev/${script}"
    done

    # Sysctl rules
    for rule in "${sysctl[@]}"; do
        install -Dm0644 "${rule}" "${pkgdir}/usr/lib/sysctl.d/${rule}"
    done
}

