# Pi-gen for RetCon

This is a fork of [RPi-Distro/pi-gen][] for [RetCon][].  It generates an SD
card image for RetCon which runs on a Raspberry Pi.

For more information, see [RetCon][].

# Dependencies

`quilt kpartx realpath qemu-user-static debootstrap zerofree pxz zip`

# Building

Run:

```sh
sudo ./build.sh /path/to/retcon.deb
```

The output will be in `deploy/`.

Ideally, read the full README from [RetCon][].

[RPi-Distro/pi-gen]: https://github.com/RPi-Distro/pi-gen
[RetCon]: https://github.com/cashpipeplusplus/retcon

# Raspbian Stage Overview

The build of Raspbian is divided up into several stages for logical clarity
and modularity.  This causes some initial complexity, but it simplifies
maintenance and allows for more easy customization.

 - Stage 0, bootstrap.  The primary purpose of this stage is to create a
   usable filesystem.  This is accomplished largely through the use of
   `debootstrap`, which creates a minimal filesystem suitable for use as a
   base.tgz on Debian systems.  This stage also configures apt settings and
   installs `raspberrypi-bootloader` which is missed by debootstrap.  The
   minimal core is installed but not configured, and the system will not quite
   boot yet.

 - Stage 1, truly minimal system.  This stage makes the system bootable by
   installing system files like `/etc/fstab`, configures the bootloader, makes
   the network operable, and installs packages like raspi-config.  At this
   stage the system should boot to a local console from which you have the
   means to perform basic tasks needed to configure and install the system.
   This is as minimal as a system can possibly get, and its arguably not
   really usable yet in a traditional sense yet.  Still, if you want minimal,
   this is minimal and the rest you could reasonably do yourself as sysadmin.

 - State 2, lite system.  This stage would normally produce the Raspbian-Lite
   image.  It installs some optimized memory functions, sets timezone and
   charmap defaults, installs fake-hwclock and ntp, wifi and bluetooth support,
   dphys-swapfile, and other basics for managing the hardware.  It also creates
   necessary groups and gives the pi user access to sudo and the standard
   console hardware permission groups.

 - Stage 3, RetCon.  This is where we started making changes from Raspbian.
   Everything in here is specific to RetCon.  This stage produces the final
   RetCon image.
