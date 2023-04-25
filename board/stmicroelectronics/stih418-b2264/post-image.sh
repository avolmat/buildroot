#!/bin/sh

set -eux

BOARD_DIR=$(dirname "$0")

# By default U-Boot loads DTB from a file named "devicetree.dtb", so
# let's use a symlink with that name that points to the *first*
# devicetree listed in the config.

FIRST_DT=$(sed -n \
           's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\(st\/\)\?\([a-z0-9\-]*\).*"$/\2/p' \
           ${BR2_CONFIG})

[ -z "${FIRST_DT}" ] || ln -fs ${FIRST_DT}.dtb ${BINARIES_DIR}/devicetree.dtb

RAMFS=""; [ -z "$(grep -E ^BR2_TARGET_ROOTFS_CPIO_UIMAGE=y ${BR2_CONFIG})" ] || RAMFS="-ramfs"

cp -f "${BOARD_DIR}/uenv${RAMFS}.txt" "${BINARIES_DIR}/uenv.txt"

# Mount /boot
if [ -e "${TARGET_DIR}/etc/fstab" ]; then
	mkdir -p "${TARGET_DIR}/boot" && touch "${TARGET_DIR}/boot/.keep"
	FSTAB="${TARGET_DIR}/etc/fstab"
	APPEND='/dev/mmcblk0p1 /boot vfat rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 0'
	grep -qxF "$APPEND" "$FSTAB" || echo "$APPEND" >> "$FSTAB"
fi

support/scripts/genimage.sh -c board/stmicroelectronics/stih418-b2264/genimage${RAMFS}.cfg
