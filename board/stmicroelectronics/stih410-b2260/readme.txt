STiH410-B2260

Intro
=====

This configuration supports the STiH410-B2260 board platform:

  https://www.96boards.org/documentation/consumer/b2260/getting-started/

How to build
============

 $ make stih410_b2260_defconfig
 $ make

How to write the microSD card / USB
===================================

Once the build process is finished you will have an image called "sdcard.img"
in the output/images/ directory.

Copy the bootable "sdcard.img" onto an microSD card with "dd":

  $ sudo dd if=images/sdcard.img of=/dev/mmcblk0 bs=8M conv=fdatasync status=progress

Boot the board from RAMFS
=========================

 (1) Insert the microSD card

 (2) Power-up the board / Reset

 (3) The system will start, with the console on UART

TODO
====

  * Rework DRM STi subsystem
  * Add support for ARM Mali 400 GPU
  * Fix sound driver issue
  * Thermal
