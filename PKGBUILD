# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=vostro1510
pkgver=0.0.1
pkgrel=1
pkgdesc="Vostro 1510-specific configuration"
arch=('any')
license=('GPL')
# Install needed packages
depends=('powersave' 'triggerhappy')

# Files to add
source=( # New files
        'multimedia.conf' # Triggerhappy multimedia key config
       )
md5sums=()
backup=("etc/triggerhappy/multimedia.conf")

package() {
    cd "${srcdir}"

    # Add the multimedia key config
    install -Dm0644 "${srcdir}/multimedia.conf" \
        "${pkgdir}/etc/triggerhappy/multimedia.conf"

    # Enable the services
    SERVICES="triggerhappy"
    mkdir -p "${pkgdir}/etc/systemd/system/multi-user.target.wants"
    for SERVICE in $SERVICES; do
        ln -s "/usr/lib/systemd/system/${SERVICE}.service" \
      "${pkgdir}/etc/systemd/system/multi-user.target.wants/${SERVICE}.service"
    done
}

