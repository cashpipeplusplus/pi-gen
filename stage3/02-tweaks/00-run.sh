#!/bin/bash -e

# Change the hostname.
install -m 644 files/hostname ${ROOTFS_DIR}/etc/hostname

on_chroot sh -e - <<EOF
# Do not wait for network to boot.
rm -f /etc/systemd/system/dhcpcd.service.d/wait.conf

# Enable SSH by default, for debugging when a network interface is plugged in.
systemctl enable ssh

# Set keyboard layout to US.
sed -e 's/XKBLAYOUT=.*/XKBLAYOUT="us"/' -i /etc/default/keyboard
EOF
