################################################################################
#
# alacritty
#
################################################################################

ALACRITTY_VERSION = 0.14.0
ALACRITTY_SITE = $(call github,alacritty,alacritty,v$(ALACRITTY_VERSION))
ALACRITTY_LICENSE = MIT
ALACRITTY_LICENSE_FILES = LICENSE-MIT
ALACRITTY_DEPENDENCIES = wayland wayland-protocols libxkbcommon freetype fontconfig

ALACRITTY_SUBDIR = alacritty
ALACRITTY_CARGO_BUILD_OPTS = --no-default-features --features=wayland
ALACRITTY_CARGO_INSTALL_OPTS = --no-default-features --features=wayland

$(eval $(cargo-package))
