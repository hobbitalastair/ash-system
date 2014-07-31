# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-base
pkgver=0.2.17
pkgrel=8
pkgdesc="Base setup for an Alastair Hughes system"
arch=('any')
license=('GPL')
# Install needed packages
depends=('fbset' 'fbpdf' 'fbv' # Framebuffer utilities
         'vim' 'lynx' 'less' 'git' 'openssh' 'sudo' 'alsa-utils' 'unzip' 
         'keychain' 'teapot' # Userspace tools
         'immix' 'ntp' # Automation of some tasks
         'xdg-user-dirs' # Uhh...?
         'ash-security' # Security stuff - sudoers config, etc...
         'patchman' 'perl' # Required for this package
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
        'pacman.ash'    # My personal additions to pacman's default config
        'colours.ash'   # Colours for ls --color

        # Unison files
        'sshd_config.sed'   # Sed script to allow the user environment
        'environment.file'  # Environment file (patch)

        # Patches
        'lynx.cfg.patch'    # Lynx config patch
        'hosts.file'        # Known hostnames 
        'sshd_config.sed'   # Sed script to 'fix' the sshd config
        'pacman.conf.sh'
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
    # Add the colors config
    install -Dm0644 "${srcdir}/colours.ash" "${pkgdir}/etc/dircolours.conf"
    # Add the sudoers file for ash
    install -dm0750 "${pkgdir}/etc/sudoers.d"
    install -Dm0440 "${srcdir}/sudoers.ash" "${pkgdir}/etc/sudoers.d/ash-base"
    # Add the pacman.conf additonal file
    install -Dm0644 "${srcdir}/pacman.ash" "${pkgdir}/etc/pacman.d/pacman.ash"


    # Add the skel files
    SKEL=".ssh .config .local .config/unison .local/share/unison/backups"
    for DIR in $SKEL; do
        mkdir -p "${pkgdir}/etc/skel/$DIR"
    done


    # Enable the services
    SERVICES="sshd ntpd dhcpcd immix"
    mkdir -p "${pkgdir}/etc/systemd/system/multi-user.target.wants"
    for SERVICE in $SERVICES; do
        ln -s "/usr/lib/systemd/system/${SERVICE}.service" \
      "${pkgdir}/etc/systemd/system/multi-user.target.wants/${SERVICE}.service"
    done


    # Add the patches
    PATCHDIR="${pkgdir}/usr/share/ash-base"
    mkdir -p "${PATCHDIR}"
    install -m0644 "${srcdir}/lynx.cfg.patch" "${PATCHDIR}/lynx.cfg.patch"
    install -m0644 "${srcdir}/hosts.file" "${PATCHDIR}/hosts.file"
    install -m0644 "${srcdir}/sshd_config.sed" \
                   "${PATCHDIR}/sshd_config.sed"
    install -m0644 "${srcdir}/environment.file" "${PATCHDIR}/environment.file"
    install -m0644 "${srcdir}/pacman.conf.sh" "${PATCHDIR}/pacman.conf.sh"
}

md5sums=('aa34cb95ea1464bd78c1967152585c5f'
         '9f727bc0a03a4de2803dd273f87759fa'
         '9ab88e97da626fd04501ad1c486deed9'
         'bd4da5f2283ef3284ce21e55faee1b51'
         'bf2a9efb5562310c62a35985f7ee56c5'
         '92d3081ea652da4b65ad4ce9484b01fa'
         'd7967ec5efc88b263e8ecbf0e5f87d2d'
         '2d499e3e1efa5725193439ee1112a905'
         '4756fc1616221f5cbe19478dee4b24fa'
         '11ac0c498dbb95cd6ad167c51062001e'
         'd7967ec5efc88b263e8ecbf0e5f87d2d'
         'a9851172265a0c39d503a5bcb0e179c2')
