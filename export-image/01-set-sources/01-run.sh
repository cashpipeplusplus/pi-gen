#!/bin/bash -e

# We have already cleaned up a bunch in RetCon stage3.
# There is no need to update/upgrade here.
# This speeds up export and avoids recreating some things we've trashed.
exit 0

on_chroot sh -e - <<EOF
apt-get update
apt-get -y dist-upgrade
apt-get clean
EOF
