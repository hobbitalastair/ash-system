# Maintainer: Alastair Hughes <hobbitalastair@gmail.com>
pkgname=ash-base
pkgver=0.5.0
pkgrel=1
pkgdesc="Base setup for an Alastair Hughes system"
arch=('any')
license=('MIT')
depends=(
         'vim'
         'less'
         'git'
         'openssh'
         'sudo'
         'unzip'
         'keychain'
         'bash-completion'
         'immix'
         'ash-security'
         'patchman'
        )
install="install.sh"
source=(
        'bash.bashrc'
        'environment'
        'hosts'
        'sshd_config.patch'
        'vim.conf'
        'terminal.sh'
        'sudoers.ash'
        'startup.py'
        'size.conf'
       )
md5sums=('29bcdc481ca6cffd349b83dea9eb88f8'
         '86d7c0ff231e094ca30ec0a26feaab2c'
         '09a7fd37a0cc4f07b5098bdfc4e7b93a'
         'dda6babbe7932766862de766a98dde11'
         'd40be3b76df1ebf3061c170c20fd4f6e'
         'a178e5568c0deeee8a7d4be6ad4490b9'
         '3e703ec70db24a9ff0b90810d51be598'
         'ac538ff79175e897ed821f4cd49d5d74'
         '372f1f188276ac5881f315169e3c4e12')

package() {
    cd "${srcdir}"

    # Install the default patches - these need to be applied manually.
    patchpath="${pkgdir}/var/lib/patchman"
    install -Dm0644 "bash.bashrc" "${patchpath}/etc/bash.bashrc"
    install -Dm0644 "environment" "${patchpath}/etc/environment"
    install -Dm0644 "hosts" "${patchpath}/etc/hosts"
    install -Dm0644 "sshd_config.patch" \
        "${patchpath}/etc/ssh/sshd_config/auth.patch"

    # Add the IGNORE flags for some files.
    for f in etc/fstab etc/passwd etc/shadow etc/group etc/gshadow \
        etc/locale.gen etc/resolv.conf etc/shells; do
        mkdir -p "${patchpath}/${f}"
        touch "${patchpath}/${f}/IGNORE"
    done

    # Add the new files.
    install -Dm0644 "vim.conf" "${pkgdir}/etc/vim.conf"
    install -Dm0755 "terminal.sh" \
                    "${pkgdir}/etc/profile.d/terminal.sh"
    install -dm0750 "${pkgdir}/etc/sudoers.d"
    install -Dm0440 "sudoers.ash" "${pkgdir}/etc/sudoers.d/ash-base"
    install -Dm0644 "startup.py" "${pkgdir}/etc/python/startup.py"
    install -Dm0644 "size.conf" \
        "${pkgdir}/etc/systemd/journald.conf.d/size.conf"

    # Add the skel files
    mkdir -p "${pkgdir}/etc/skel/.config"
    mkdir -p "${pkgdir}/etc/skel/.config/unison"
    mkdir -p "${pkgdir}/etc/skel/.local/share/unison/backups"
    mkdir -p "${pkgdir}/etc/skel/.local/share/vim"

    # Enable the services
    SERVICES="sshd dhcpcd systemd-timesyncd immix"
    mkdir -p "${pkgdir}/etc/systemd/system/multi-user.target.wants"
    for SERVICE in $SERVICES; do
        ln -s "/usr/lib/systemd/system/${SERVICE}.service" \
      "${pkgdir}/etc/systemd/system/multi-user.target.wants/${SERVICE}.service"
    done
}
