# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-desktop
pkgver=0.3
pkgrel=15
pkgdesc="Basic desktop setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
depends=('xorg-server' 'xorg-xinit' 'fvwm' 'chromium' 'gnome-themes-standard'
         'oxygen-icons' 'xterm')
optdepends=('xf86-video-fb: Basic X desktop driver'
            'xf86-video-intel: Graphics acceleration for x86 intel graphics'
            'libva-intel-driver: Video playback acceleration for x86 intel graphics')
source=('arch_wallpaper.png'
        'arch_icon.png'
        'fvwm-config'
        'gtkrc-2' 
        'desktop.sh'
        'xinitrc.file')
install='install.sh'

package() {
    cd "${srcdir}"
    # Wallpaper for the desktop and the start icon
    mkdir -p "${pkgdir}/usr/share/ash-desktop/images"
    cp "${srcdir}/arch_wallpaper.png" "${pkgdir}/usr/share/ash-desktop/images/arch_wallpaper.png"
    cp "${srcdir}/arch_icon.png" "${pkgdir}/usr/share/ash-desktop/images/arch_icon.png"
    # Fvwm config
    mkdir -p "${pkgdir}/etc/fvwm"
    cp -p "${srcdir}/fvwm-config" "${pkgdir}/etc/fvwm/config"
    # Global GTK config
    mkdir -p "${pkgdir}/etc/gtk-2.0"
    cp "${srcdir}/gtkrc-2" "${pkgdir}/etc/gtk-2.0/gtkrc"
    # Desktop related variables
    mkdir -p "${pkgdir}/etc/profile.d/"
    cp "${srcdir}/desktop.sh" "${pkgdir}/etc/profile.d/desktop.sh"

    # Patch location
    PATCHDIR="${pkgdir}/usr/share/ash-desktop"
    mkdir -p "${PATCHDIR}"

    # Patch for xinitrc
    mkdir -p "${pkgdir}/etc/X11/xinit/"
    cp "${srcdir}/xinitrc.file" "${PATCHDIR}"
}

md5sums=('d3dd6ace54f482c61a9973f25d2c2e74'
         '4eddc050f9acc78238fbf03b3489dca5'
         'eab0c9c7b55ee537a0f0e682595c991c'
         'a11fe3f8b7c163483c7225a549eb0cc6'
         '1d1d3310aabea5d9318e7322f88449b4'
         '9ff430e591ed740798e0e1d97074cfdc')
