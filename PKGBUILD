# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=dx2180
pkgver=0.2
pkgrel=1
pkgdesc="dx2180-specific configuration"
arch=('any')
license=('GPL')
depends=('cdrtools' 'intel-ucode' 'tinyserial' 'unison-240'
        'btrfs-progs' 'syslinux')

# Files to add
backup=("etc/modprobe.d/nobeep.conf")

package() {
    cd "${srcdir}"

    # Disable the PC speaker beep
    mkdir -p "${pkgdir}/etc/modprobe.d/"
    printf 'blacklist pcspkr\n' > "${pkgdir}/etc/modprobe.d/nobeep.conf"
}
