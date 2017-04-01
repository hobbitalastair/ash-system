# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-desktop
pkgver=0.8
pkgrel=2
pkgdesc="Basic desktop setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
install=install.sh
depends=('chromium' 'gnome-themes-standard' 'oxygen-icons' 'pepper-flash'
        'dwm' 'xssstate' 'slock' 'slstatus' 'redshift'
        'xorg-server' 'xorg-xinit' 'xclip'
        'tigervnc' 'rdesktop'
        'cups' 'ghostscript' 'foo2zjs'
        'rct')
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

    # Set the default papersize.
    mkdir -p "${pkgdir}/var/lib/patchman/etc/"
    printf 'A4\n' > "${pkgdir}/var/lib/patchman/etc/papersize"
}
