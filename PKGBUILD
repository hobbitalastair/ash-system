# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-desktop
pkgver=0.7
pkgrel=2
pkgdesc="Basic desktop setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
depends=('chromium' 'matchbox-window-manager' 'gnome-themes-standard'
        'oxygen-icons' 'xorg-server' 'xorg-xinit' 'pepper-flash')
source=('gtkrc-2'
        'desktop.sh')
md5sums=('050d0a2ed0ecb66bea06db9692bfc549'
         'a58f90c5db213979878b0663eb61e2a7')

package() {
    cd "${srcdir}"

    # Global GTK config
    install -Dm0644 "${srcdir}/gtkrc-2" "${pkgdir}/etc/gtk-2.0/gtkrc"

    # Desktop profile.
    install -Dm0644 "${srcdir}/desktop.sh" "${pkgdir}/etc/profile.d/desktop.sh"
}

