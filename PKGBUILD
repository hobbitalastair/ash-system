# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-base
pkgver=0.4.0
pkgrel=1
pkgdesc="Base setup for an Alastair Hughes system"
arch=('any')
license=('MIT')
# Install needed packages
depends=(
         'vim' 'lynx' 'less' 'git' 'openssh' 'sudo' 'alsa-utils' 'unzip'
         'keychain' 'teapot' 'bash-completion' 'hunspell' 'hunspell-en' 
         'snownews' 'vorbis-tools'
         'immix'        # Automation of some tasks
         'ash-security' # Security stuff - sudoers config, etc...
         'patchman'
        )
# Start the various services and add ash (the user)
install='install.sh'
# Files to add
source=( # New files
        'vim.conf'      # Global vim config
        'terminal.sh'   # Env variables and alias for ash
        'sudoers.ash'   # Sudoers config for ash
        'gitconfig'     # Global git config
        'pacman.ash'    # My personal additions to pacman's default config
        'colours.ash'   # Colours for ls --color
        'startup.py'    # Python interactive startup code
        'size.conf'     # journald options to limit size

        # Unison files
        'environment.file'  # Environment file (patch)

        # Patches
        'hosts.file'        # Known hostnames 
        'sshd_config.sed'   # Sed script to 'fix' the sshd config
        'pacman.conf.sh'    # Add an include for pacman.ash
        'bash.bashrc.file'  # File to remove bash stuff
       )
md5sums=('d40be3b76df1ebf3061c170c20fd4f6e'
         '6b7206c77085adaf2c9e65d5284e88eb'
         '3e703ec70db24a9ff0b90810d51be598'
         'bd4da5f2283ef3284ce21e55faee1b51'
         '980a68bf472eabddb3cd64dbd2febc5e'
         'bb75d24376419f8261d47c705b12e0bc'
         '2448318f3167cb0ccfa72abbd32dd5de'
         '372f1f188276ac5881f315169e3c4e12'
         '86d7c0ff231e094ca30ec0a26feaab2c'
         'd01cb959e0c8bc7ddd78ccc301d98023'
         '6406220887fef61bd8c2b8265d8b0985'
         'a9851172265a0c39d503a5bcb0e179c2'
         'fec2b1c71d884437d7cc96ba9ad34d53')

package() {
    cd "${srcdir}"

    # Add vim's config
    install -Dm0644 "${srcdir}/vim.conf" "${pkgdir}/etc/vim.conf"
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
    # Add the python startup code.
    install -Dm0644 "${srcdir}/startup.py" "${pkgdir}/etc/python/startup.py"
    # Add the journald config snippet.
    install -Dm0644 "${srcdir}/size.conf" \
        "${pkgdir}/etc/systemd/journald.conf.d/size.conf"


    # Add the skel files
    SKEL=".ssh .config .local .config/unison .local/share/unison/backups 
        .local/share/vim"
    for DIR in $SKEL; do
        mkdir -p "${pkgdir}/etc/skel/$DIR"
    done


    # Enable the services
    SERVICES="sshd dhcpcd immix systemd-timesyncd"
    mkdir -p "${pkgdir}/etc/systemd/system/multi-user.target.wants"
    for SERVICE in $SERVICES; do
        ln -s "/usr/lib/systemd/system/${SERVICE}.service" \
      "${pkgdir}/etc/systemd/system/multi-user.target.wants/${SERVICE}.service"
    done


    # Add the patches
    PATCHDIR="${pkgdir}/usr/share/ash-base"
    mkdir -p "${PATCHDIR}"
    install -m0644 "${srcdir}/hosts.file" "${PATCHDIR}/hosts.file"
    install -m0644 "${srcdir}/sshd_config.sed" \
                   "${PATCHDIR}/sshd_config.sed"
    install -m0644 "${srcdir}/environment.file" "${PATCHDIR}/environment.file"
    install -m0644 "${srcdir}/pacman.conf.sh" "${PATCHDIR}/pacman.conf.sh"
    install -m0644 "${srcdir}/bash.bashrc.file" "${PATCHDIR}/bash.bashrc.file"
}
