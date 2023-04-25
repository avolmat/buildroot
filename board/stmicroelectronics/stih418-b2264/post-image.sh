#!/bin/sh

BOARD_DIR=$(dirname "$0")

# By default U-Boot loads DTB from a file named "devicetree.dtb", so
# let's use a symlink with that name that points to the *first*
# devicetree listed in the config.

FIRST_DT=$(sed -n \
           's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\([a-z0-9\-]*\).*"$/\1/p' \
           ${BR2_CONFIG})

[ -z "${FIRST_DT}" ] || ln -fs ${FIRST_DT}.dtb ${BINARIES_DIR}/devicetree.dtb

RAMFS=""; [ -z "$(grep -E ^BR2_TARGET_ROOTFS_CPIO_UIMAGE=y ${BR2_CONFIG})" ] || RAMFS="-ramfs"

cp -f "${BOARD_DIR}/uenv${RAMFS}.txt" "${BINARIES_DIR}/uenv.txt"

support/scripts/genimage.sh -c board/stmicroelectronics/stih418-b2264/genimage${RAMFS}.cfg
