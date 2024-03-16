#!/bin/sh

set -eux

BOARD_DIR=$(dirname "$0")
BOOT_DIR="b2260"

# Copy scripts to images directory in order to build boot.vfat
cp -f "${BOARD_DIR}/uEnv_sd.txt" "${BINARIES_DIR}/uEnv_sd.txt"
cp -f "${BOARD_DIR}/u-bootrom.script" "${BINARIES_DIR}/u-bootrom.script"
cp -f "${BOARD_DIR}/u-bootrom.script-kernel" "${BINARIES_DIR}/u-bootrom.script-kernel"
cp -f "${BOARD_DIR}/u-bootrom.script-netboot" "${BINARIES_DIR}/u-bootrom.script-netboot"
cp -f "${BOARD_DIR}/u-bootrom.script-uboot" "${BINARIES_DIR}/u-bootrom.script-uboot"
cp -f "${BOARD_DIR}/extlinux.conf" "${BINARIES_DIR}/extlinux.conf"

# Mount /boot
if [ -e "${TARGET_DIR}/etc/fstab" ]; then
	mkdir -p "${TARGET_DIR}/boot" && touch "${TARGET_DIR}/boot/.keep"
	FSTAB="${TARGET_DIR}/etc/fstab"
	APPEND='/dev/mmcblk0p1 /boot vfat rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 0'
	grep -qxF "$APPEND" "$FSTAB" || echo "$APPEND" >> "$FSTAB"
fi

support/scripts/genimage.sh -c board/stmicroelectronics/stih410-b2260/genimage.cfg
