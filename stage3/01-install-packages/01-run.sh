#!/bin/bash -e

# Install the local retcon package.
cp ${RETCON_DEB} ${ROOTFS_DIR}/retcon.deb

on_chroot sh -e - <<EOF
dpkg -i /retcon.deb
EOF

rm -f ${ROOTFS_DIR}/retcon.deb
