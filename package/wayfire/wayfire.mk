################################################################################
#
# wayfire
#
################################################################################

WAYFIRE_VERSION = cf9afeda562ff4bb46bf2923723a744fbf832efd
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
