# Maintainer: Alastair Hughes < hobbitalastair at yandex dot com>

# Package information
pkgname='ash-avr'
pkgver='1.0'
pkgrel=1
pkgdesc="Packages for the UCFK4 avr device"

# Additional information...
arch=('any')
url="https://ecewiki.elec.canterbury.ac.nz/mediawiki/index.php/UCFK4"
license=('MIT')

# Dependency information
depends=('avr-gcc' 'avr-libc' 'dfu-programmer')

# Building information
source=(99-avr.rules)
md5sums=('fd024cbdb69dd7c6ba7ec6cb1d9e8d2b')


package() {
    cd "${srcdir}"

    install -Dm0644 "99-avr.rules" "${pkgdir}/usr/lib/udev/rules.d/99-avr.rules"
}
