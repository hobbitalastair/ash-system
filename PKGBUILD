# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-base
pkgver=0.2.1
pkgrel=1
pkgdesc="Base setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
depends=('fbset' 'fbpdf' 'fbv' 'git' 'ntp' 'vim' 'lynx' 'python' 'ash-security'
         'unison' 'less' 'patchman' 'unzip' 'alsa-utils' 'xdg-user-dirs')

# Remove unwanted packages.
conflicts=('nano' 's-nail' 'reiserfsprogs' 'xfsprogs' 'mdadm' 'lvm2' 'jfsutils')
# Start the various services and add ash (the user)
install='install.sh'
# Files to add
source=( # New files
        'vim.config'
        'cron.allow'
        'gitconfig'
        'terminal.sh'
        '9-ash'

        # Patches
        'lynx.cfg.patch'
        'hosts.patch'
       )

package() {
    cd "${srcdir}"

    # Add vim's config
    mkdir -p "${pkgdir}/etc"
    cp "${srcdir}/vim.config" "${pkgdir}/etc/vim.conf"

    # Add cron.allow
    cp "${srcdir}/cron.allow" "${pkgdir}/etc/cron.allow"
    # Make non-writable
    chmod a-wx "${pkgdir}/etc/cron.allow"

    # Add gitconfig
    cp "${srcdir}/gitconfig" "${pkgdir}/etc/gitconfig"

    # Add the default profile file
    mkdir "${pkgdir}/etc/profile.d"
    cp "${srcdir}/terminal.sh" "${pkgdir}/etc/profile.d/terminal.sh"

    # Add the sudoers file for ash
    mkdir -p "${pkgdir}/etc/sudoers.d"
    install -Dm0440 "${srcdir}/9-ash" "${pkgdir}/etc/sudoers.d"

    # Add the patches
    PATCHDIR="${pkgdir}/usr/share/ash-base"
    mkdir -p "${PATCHDIR}"
    cp "${srcdir}/lynx.cfg.patch" "${PATCHDIR}"
    cp "${srcdir}/hosts.patch" "${PATCHDIR}"
}

md5sums=('16086a76c0267dcbc6826bb64160d0ef'
         '4fe8b88e09e2bc93d8835250bca2e776'
         'bd4da5f2283ef3284ce21e55faee1b51'
         'a34a7677f6b5301996a25141ab1d2e4c'
         '97d008f19c0db4bf39ae6b98f51730cd'
         '63f2c9b04548e5a881b9b259a34f5ce9')
