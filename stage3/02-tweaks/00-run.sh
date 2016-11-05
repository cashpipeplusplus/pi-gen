#!/bin/bash -e

# Change the hostname.
install -m 644 files/hostname ${ROOTFS_DIR}/etc/hostname

on_chroot sh -e - <<EOF
# Remove some packages we don't need.
apt-get remove -y --purge avahi-daemon cron logrotate triggerhappy
apt-get autoremove -y

# Enable SSH by default, for debugging when a network interface is plugged in.
systemctl enable ssh
EOF