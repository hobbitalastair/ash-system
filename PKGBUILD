# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-desktop
pkgver=0.5
pkgrel=1
pkgdesc="Basic desktop setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
depends=('chromium' 'gnome-themes-standard' 'oxygen-icons' 'weston'
    'xorg-server-xwayland')
source=('gtkrc-2')

package() {
    cd "${srcdir}"

    # Global GTK config
    install -Dm0664 "${srcdir}/gtkrc-2" "${pkgdir}/etc/gtk-2.0/gtkrc"
}

md5sums=('050d0a2ed0ecb66bea06db9692bfc549')
