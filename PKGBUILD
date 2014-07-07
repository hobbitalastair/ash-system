# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-base
pkgver=0.2.14
pkgrel=2
pkgdesc="Base setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
depends=('fbset' 'fbpdf' 'fbv' # Framebuffer utilities
         'vim' 'lynx' 'less' 'git' 'openssh' 'sudo' 'alsa-utils' 'unzip' 
         'keychain' # Userspace tools
         'immix' 'ntp' # Automation of some tasks
         'xdg-user-dirs' # Uhh...?
         'ash-security' # Security stuff - sudoers config, etc...
         'patchman' # Required for this package
        )

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

        # Unison files
        'sshd_config.sed'   # Sed script to allow the user environment
        'environment.file'  # Environment file (patch)

        # Patches
        'lynx.cfg.patch'    # Lynx config patch
        'hosts.file'        # Known hostnames 
        'sshd_config.sed'   # Sed script to 'fix' the sshd config
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

    # Add the skel files
    SKEL=".ssh .config .local .config/unison .local/share/unison/backups"
    for DIR in $SKEL; do
        mkdir -p "${pkgdir}/etc/skel/$DIR"
    done

    # Enable the services
    SERVICES="sshd ntpd dhcpcd immix"
    mkdir -p "${pkgdir}/etc/systemd/system/multiuser.target.wants"
    for SERVICE in $SERVICES; do
        ln -s "/usr/lib/systemd/system/${SERVICE}.service" \
      "${pkgdir}/etc/systemd/system/multiuser.target.wants/${SERVICE}.service"
    done

    # Add the patches
    PATCHDIR="${pkgdir}/usr/share/ash-base"
    mkdir -p "${PATCHDIR}"
    install -m0644 "${srcdir}/lynx.cfg.patch" "${PATCHDIR}/lynx.cfg.patch"
    install -m0644 "${srcdir}/hosts.file" "${PATCHDIR}/hosts.file"
    install -m0644 "${srcdir}/sshd_config.sed" \
                   "${PATCHDIR}/sshd_config.sed"
    install -m0644 "${srcdir}/environment.file" "${PATCHDIR}/environment.file"
}

md5sums=('16086a76c0267dcbc6826bb64160d0ef'
         'f86d0d28892ef0e15b35e4c96b925ab2'
         '9ab88e97da626fd04501ad1c486deed9'
         'bd4da5f2283ef3284ce21e55faee1b51'
         'd7967ec5efc88b263e8ecbf0e5f87d2d'
         'e05c617da3f0f3688b476a854ec74466'
         '97d008f19c0db4bf39ae6b98f51730cd'
         '75063996f8637a7bb42b1a37102a7a2a'
         'd7967ec5efc88b263e8ecbf0e5f87d2d')
