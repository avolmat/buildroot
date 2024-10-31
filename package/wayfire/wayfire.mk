################################################################################
#
# wayfire
#
################################################################################

WAYFIRE_VERSION = 3d3f426f7de8a24117f6c1d33c8dead1bc80b7e9
WAYFIRE_SITE = https://github.com/WayfireWM/wayfire
WAYFIRE_SITE_METHOD = git
WAYFIRE_GIT_SUBMODULES = YES
WAYFIRE_LICENSE = MIT
WAYFIRE_LICENSE_FILES = LICENSE
WAYFIRE_DEPENDENCIES = host-pkgconf wlroots glm json-for-modern-cpp cairo pango
WAYFIRE_INSTALL_STAGING = YES
WAYFIRE_CONF_OPTS = \
	-Dwerror=false

define WAYFIRE_USERS
	wayfire -1 wayfire -1 * /home/wayfire /bin/sh seat,audio,video Wayfire user
endef

$(eval $(meson-package))
