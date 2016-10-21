# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=dx2180
pkgver=0.1.0
pkgrel=1
pkgdesc="dx2180-specific configuration"
arch=('any')
license=('GPL')

# Files to add
backup=("etc/modprobe.d/nobeep.conf")

package() {
    cd "${srcdir}"

    # Disable the PC speaker beep
    mkdir -p "${pkgdir}/etc/modprobe.d/nobeep.conf"
    printf 'blacklist pcspkr\n' > "${pkgdir}/etc/modprobe.d/nobeep.conf"
}
