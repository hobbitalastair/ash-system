# Maintainer: Alastair Hughes <hobbitalastair at yandex dot com>

pkgname="palm"
pkgver="0.1"
pkgrel=1
pkgdesc="Extras to configure coldsync or similar to run as a service"
arch=('any')
url=""
license=('MIT')
depends=('coldsync-git' 'udev')
backup=('etc/coldsync/coldsync.conf'
        'etc/coldsync/palms')
source=('80-palm.rules'
        'coldsync@.service'
        'coldsync.conf'
        'palms')
md5sums=('a65f9516b05f4d9a14d0da663daac968'
         'b691767ad26637a50cd1f9ade81ff419'
         '971e6b3537aea4d5b20753f28bfc384b'
         '106223074486301c70329459aec5683d')

package() {
    cd "${srcdir}"

    mkdir -p "${pkgdir}/etc/coldsync/"
    install -m0644 "coldsync.conf" "${pkgdir}/etc/coldsync/coldsync.conf"
    install -m0644 "palms" "${pkgdir}/etc/coldsync/palms"

    install -Dm0644 "80-palm.rules" \
        "${pkgdir}/usr/lib/udev/rules.d/80-palm.rules"

    install -Dm0644 "coldsync@.service" \
        "${pkgdir}/usr/lib/systemd/system/coldsync@.service"

}
