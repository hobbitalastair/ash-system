# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=framebuffer
pkgver=0.4
pkgrel=1
pkgdesc="Framebuffer utilities for an Alastair Hughes system"
arch=('any')
license=('MIT')
# Install needed packages
depends=('fbset' 'fbpdf' 'fbv' # Framebuffer utilities
        'librsvg' # For svg viewing
        'lynx' 'snownews' 'teapot'
        'alsa-utils'
        'vorbis-tools'
        'hunspell' 'hunspell-en'
        'mps-youtube' 'mpv' 'youtube-dl'
        'texlive-core'
        )
# Files to add
source=('fbsvg.sh')
md5sums=('e9a02e005989d64d036f214aee14b48b')

package() {
    cd "${srcdir}"

    install -Dm0755 "${srcdir}/fbsvg.sh" "${pkgdir}/usr/bin/fbsvg"
}
