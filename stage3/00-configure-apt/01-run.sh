#!/bin/bash -e

install -m 644 files/retcon.list ${ROOTFS_DIR}/etc/apt/sources.list.d/

on_chroot apt-key add - < files/cashpipeplusplus.gpg.key
on_chroot sh -e - << EOF
apt-get update
EOF
