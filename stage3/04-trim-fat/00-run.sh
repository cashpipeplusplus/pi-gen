#!/bin/bash -e

# NOTE: must be bash, since I'm using fancy expansions below.
on_chroot bash -e - <<EOF
# Remove some packages we don't need.
apt-get remove -y --purge avahi-daemon logrotate triggerhappy dphys-swapfile
apt-get remove -y --purge libraspberrypi-dev libraspberrypi-doc libfreetype6-dev
apt-get autoremove -y --purge

# Trash kernel for old Pi 2 models (we use Pi zero only).
rm -rf /lib/modules/4.4.26-v7+ /boot/kernel7.img

# Trash docs.
rm -rf /usr/share/doc /usr/share/man

# Trash non-English locales.
mkdir /usr/share/locale.bk
mv /usr/share/locale/{en*,locale.alias} /usr/share/locale.bk/
rm -rf /usr/share/locale
mv /usr/share/locale{.bk,}

# Trash non-English i18n.
mkdir /usr/share/i18n/locales.bk
mv /usr/share/i18n/locales/{en*,C,POSIX,i18n} /usr/share/i18n/locales.bk/
rm -rf /usr/share/i18n/locales
mv /usr/share/i18n/locales{.bk,}

mkdir /usr/share/i18n/charmaps.bk
mv /usr/share/i18n/charmaps/UTF-8.gz /usr/share/i18n/charmaps.bk/
rm -rf /usr/share/i18n/charmaps
mv /usr/share/i18n/charmaps{.bk,}

grep 'en_.*UTF-8' /usr/share/i18n/SUPPORTED > /usr/share/i18n/SUPPORTED.bk
mv /usr/share/i18n/SUPPORTED{.bk,}

# Clean up.
apt-get clean
rm -rf /var/lib/apt/lists
EOF
