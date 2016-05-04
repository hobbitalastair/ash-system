# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=framebuffer
pkgver=0.1
pkgrel=1
pkgdesc="Framebuffer utilities for an Alastair Hughes system"
arch=('any')
license=('MIT')
# Install needed packages
depends=('fbset' 'fbpdf' 'fbv' # Framebuffer utilities
        'librsvg' # For svg viewing
        )
# Files to add
source=('fbsvg.sh')
md5sums=('84f8213f1c7a787f61e983a199b40f9a')

package() {
    cd "${srcdir}"

    install -Dm0644 "${srcdir}/fbsvg.sh" "${pkgdir}/usr/bin/fbsvg"

}
