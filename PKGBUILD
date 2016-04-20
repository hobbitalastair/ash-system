# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-desktop
pkgver=0.6
pkgrel=1
pkgdesc="Basic desktop setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
depends=('chromium' 'matchbox-window-manager' 'gnome-themes-standard' 'oxygen-icons')
source=('gtkrc-2'
        'desktop.sh')
md5sums=('050d0a2ed0ecb66bea06db9692bfc549'
         '8562bc38febcdb9fb951f05446c6bf11')

package() {
    cd "${srcdir}"

    # Global GTK config
    install -Dm0644 "${srcdir}/gtkrc-2" "${pkgdir}/etc/gtk-2.0/gtkrc"

    # Desktop profile.
    install -Dm0644 "${srcdir}/desktop.sh" "${pkgdir}/etc/profile.d/desktop.sh"
}

