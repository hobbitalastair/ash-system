# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=xwing
pkgver=1.0
pkgrel=1
pkgdesc="X-Wing wikia mirror"
arch=('any')
license=('MIT')
# Install needed packages
depends=('python' 'python-requests')
# Files to add
source=('wikia.py' 'xwing-mirror.service')
md5sums=('866eb651faa1c57a8d69e528185f8974'
         '07c7939b6df00fe16e6913793148b7a0')

package() {
    cd "${srcdir}"

    # Install the script.
    install -Dm0755 "wikia.py" "${pkgdir}/usr/lib/systemd/scripts/wikia.py"
    # Install the service file.
    install -Dm0644 "xwing-mirror.service" \
        "${pkgdir}/usr/lib/systemd/system/xwing-mirror.service"

    # Enable the service.
    mkdir -p "${pkgdir}/etc/systemd/system/multi-user.target.wants"
    ln -s "/usr/lib/systemd/system/xwing-mirror.service" \
      "${pkgdir}/etc/systemd/system/multi-user.target.wants/xwing-mirror.service"
}
