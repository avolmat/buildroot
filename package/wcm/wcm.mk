################################################################################
#
# wcm
#
################################################################################

WCM_VERSION = 0.9.0
WCM_SOURCE = wcm-$(WCM_VERSION).tar.xz
WCM_SITE = https://github.com/WayfireWM/wcm/releases/download/v$(WCM_VERSION)
WCM_INSTALL_STAGING = YES
WCM_LICENSE = MIT
WCM_LICENSE_FILES = LICENSE
WCM_DEPENDENCIES = host-pkgconf host-vala wayfire librsvg gtkmm3 libgtk3 python3 gobject-introspection
WCM_CONF_OPTS = \
	-Dwerror=false

$(eval $(meson-package))
