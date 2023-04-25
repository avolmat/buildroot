STih418-B2264 / 4kOpen

Intro
=====

This configuration supports the STIh418-B2264 (4kOpen) board
platform:

  https://www.4kopen.com/

How to build
============

 $ make stih418_b2264_defconfig / make stih418_b2264_ramfs_defconfig
 $ make

How to write the microSD card / USB
===================================

Once the build process is finished you will have an image called
"sdcard.img" in the output/images/ directory.

Copy the bootable "sdcard.img" onto an microSD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Boot the board from RAMFS
=========================

 (1) Insert the microSD card

 (2) Power-up the board / Reset

 (3) The system will start, with the console on UART


Under the wood
==============

check "diff -uprN configs/stih418_b2264_defconfig configs/stih418_b2264_ramfs_defconfig"

if BR2_TARGET_ROOTFS_CPIO_UIMAGE=y is selected, then initrd is generated
and kernel bootargs will use "board/stmicroelectronics/stih418-b2264/uenv-ramfs.txt"

else (default), 2nd partition (ext4) is created for rootfs, and kernel bootargs will 
use "board/stmicroelectronics/stih418-b2264/uenv.txt"


Memory map
==========

  Position in memory (max DTB 1Mo, max uImage 15Mo)

  +-0x40000000----+
  |   ~1.34Go     | ^
  |               | |
  +-0x94000000----+ |
  | uImage - 15Mo | |
  +-0x94f00000----+ | 2Go
  | dtb    -  1Mo | |
  +-0x95000000----+ |
  | rootfs        | |
  |               | |
  |    ~688Mo     | |
  +-0xc0000000----+ v

Wayland tips
============

  # Start Weston from root console (plug USB mouse/keyboard first)
  if test -z "${XDG_RUNTIME_DIR}"; then
      export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
      if ! test -d "${XDG_RUNTIME_DIR}"; then
          mkdir "${XDG_RUNTIME_DIR}"
          chmod 0700 "${XDG_RUNTIME_DIR}"
      fi
  fi

  weston --idle-time=0

  # Demos from Weston terminal
  glmark2-es2-wayland --run-forever
  es2gears_wayland

Audio tips
==========

1st, put FDMA firmware into /lib/firmware

Aplay (alsa-utils) can show you device playback ( 1 x Analog, 1 x HDMI)
  # aplay -l
  **** List of PLAYBACK Hardware Devices ****
  card 0: STIB2264 [STI-B2264], device 0: Uni Player #2 (DAC)-sas-dai-dac sas-dai-dac-0 [Uni Player #2 (DAC)-sas-dai-dac sas-dai-dac-0]
    Subdevices: 1/1
    Subdevice #0: subdevice #0
  card 0: STIB2264 [STI-B2264], device 1: Uni Player #0 (HDMI)-i2s-hifi i2s-hifi-1 [Uni Player #0 (HDMI)-i2s-hifi i2s-hifi-1]
    Subdevices: 1/1
    Subdevice #0: subdevice #0

  # playback on Analog outpout
  aplay --device=plughw:0,0 sound.wav

  # playback on HDMI outpout
  aplay --device=plughw:0,1 sound.wav

--------- LEGACY Chapter ----------

How to write the microSD card / USB
===================================

Once the build process is finished you will have an image called
"sdcard.img" in the output/images/ directory.

Copy the bootable "sdcard.img" onto an microSD card with "dd":

  $ sudo dd if=output/images/sdcard.img of=/dev/sdX

Or simply put "uImage", "stih418-b2264-box.dtb", "rootfs.cpio.uboot"
on USB FAT partition.

Boot the board from RAMFS
=========================

 (1) Insert the microSD card or USB into USB3 port

 (2) From u-boot console (once, then type "saveenv")
     µSD: setenv buildroot 'mmc rescan; fatload mmc 0:1 0x94000000 uimage; \
	  fatload mmc 0:1 0x94f00000 devicetree.dtb; \
	  fatload mmc 0:1 0x95000000 uramdisk.image.gz; \
	  setenv bootargs "console=ttyAS0,115200 loglevel=7 \
	  earlyprintk quiet root=/dev/ram0 rw \
	  initrd=0x95000040,0x${filesize}"; bootm 0x94000000 0x95000000 0x94f00000'

     USB: setenv buildroot 'usb start; fatload usb 0:1 0x94000000 uImage; \
	  fatload usb 0:1 0x94f00000 stih418-b2264-box.dtb; \
	  fatload usb 0:1 0x95000000 rootfs.cpio.uboot; \
	  setenv bootargs "console=ttyAS0,115200 loglevel=7 \
	  earlyprintk quiet root=/dev/ram0 rw \
	  initrd=0x95000040,0x${filesize}"; bootm 0x94000000 0x95000000 0x94f00000'

 (3) from u-boot console "run buildroot"

Boot the board from rootfs as 2nd partition
===========================================

 (1) Create a 2nd partition on µSD (ext4)
     then extract rootfs from output/images/rootfs.tar

 (2) From u-boot console (once, then type "saveenv")
     µSD: setenv buildroot_ext4 'mmc rescan; fatload mmc 0:1 0x94000000 uimage; \
          fatload mmc 0:1 0x94f00000 devicetree.dtb; \
          setenv bootargs "console=ttyAS0,115200 loglevel=7 earlyprintk \
          quiet root=/dev/mmcblk0p2 rootwait"; bootm 0x94000000 - 0x94f00000'

 (3) from u-boot console "run buildroot_ext4"

FIXME
=====
 - Understand the 0x40 offset for Initrd, should be take in account in bootm....

