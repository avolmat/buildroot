################################################################################
#
# cage
# !! FIXME wlroots 0.7.y !! eaeab71ffa3ab5884df09c5664c00e368ca2585e
# https://github.com/cage-kiosk/cage/commits/master/
################################################################################

CAGE_VERSION = 0.1.5
CAGE_SITE = https://github.com/Hjdskes/cage/releases/download/v$(CAGE_VERSION)
CAGE_LICENSE = MIT
CAGE_LICENSE_FILES = LICENSE
CAGE_DEPENDENCIES = host-pkgconf wlroots
CAGE_CONF_OPTS = -Dman-pages=disabled

ifeq ($(BR2_PACKAGE_WLROOTS_X11),y)
CAGE_CONF_OPTS += -Dxwayland=true
else
CAGE_CONF_OPTS += -Dxwayland=false
endif

$(eval $(meson-package))
