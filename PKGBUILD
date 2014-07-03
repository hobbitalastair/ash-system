# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-base
pkgver=0.2.10
pkgrel=1
pkgdesc="Base setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
depends=('fbset' 'fbpdf' 'fbv' 'git' 'ntp' 'vim' 'lynx' 'python' 'ash-security'
         'unison' 'less' 'patchman' 'unzip' 'alsa-utils' 'xdg-user-dirs'
         'openssh' 'keychain')

# Remove unwanted packages.
conflicts=('nano' 's-nail')
# Start the various services and add ash (the user)
install='install.sh'
# Files to add
source=( # New files
        'vim.config'    # Global vim config
        'terminal.sh'   # Env variables and alias for ash
        'sudoers.ash'   # Sudoers config for ash
        'gitconfig'     # Global git config
        'unison.ash'    # Unison preference file

        # Patches
        'lynx.cfg.patch'    # Lynx config patch
        'hosts.file'        # Known hostnames 
       )
backup=("etc/sudoers.d/ash-base")

package() {
    cd "${srcdir}"

    # Add vim's config
    install -Dm0644 "${srcdir}/vim.config" "${pkgdir}/etc/vim.conf"

    # Add gitconfig
    install -Dm0644 "${srcdir}/gitconfig" "${pkgdir}/etc/gitconfig"

    # Add the default profile file
    install -Dm0755 "${srcdir}/terminal.sh" \
                    "${pkgdir}/etc/profile.d/terminal.sh"

    # Add the sudoers file for ash
    install -dm0750 "${pkgdir}/etc/sudoers.d"
    install -Dm0440 "${srcdir}/sudoers.ash" "${pkgdir}/etc/sudoers.d/ash-base"

    # Add ash's home directory
    install -dm0750 "${pkgdir}/home/ash"

    # Add the unison config and backup dir
    install -dm0750 "${srcdir}/home/ash/.config/unison/backups"
    install -Dm0660 "${srcdir}/unison.ash" \
                    "${pkgdir}/home/ash/.config/unison/home.prf" 

    # Add the patches
    _PATCHDIR="${pkgdir}/usr/share/ash-base"
    mkdir -p "${_PATCHDIR}"
    cp "${srcdir}/lynx.cfg.patch" "${_PATCHDIR}"
    cp "${srcdir}/hosts.file" "${_PATCHDIR}/hosts.file"
}

md5sums=('16086a76c0267dcbc6826bb64160d0ef'
         'e93e219587aef11ed68c6022bb4918de'
         '9ab88e97da626fd04501ad1c486deed9'
         'bd4da5f2283ef3284ce21e55faee1b51'
         '207079e07d16df6ecc23c40a502c1e2d'
         '97d008f19c0db4bf39ae6b98f51730cd'
         '99f00d3c016314e040beaa4f4c36c8db')
