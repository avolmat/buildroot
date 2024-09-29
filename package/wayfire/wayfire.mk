################################################################################
#
# wayfire
#
################################################################################

WAYFIRE_VERSION = 0.9.0
WAYFIRE_SOURCE = wayfire-$(WAYFIRE_VERSION).tar.xz
WAYFIRE_INSTALL_STAGING = YES
WAYFIRE_SITE = https://github.com/WayfireWM/wayfire/releases/download/v$(WAYFIRE_VERSION)
WAYFIRE_LICENSE = MIT
WAYFIRE_LICENSE_FILES = LICENSE
WAYFIRE_DEPENDENCIES = host-pkgconf wlroots glm json-for-modern-cpp cairo pango
WAYFIRE_CONF_OPTS = \
	-Dwerror=false

define WAYFIRE_USERS
	wayfire -1 wayfire -1 * /home/wayfire /bin/sh seat,audio,video Wayfire user
endef

$(eval $(meson-package))
