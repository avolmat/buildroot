################################################################################
#
# libdbusmenu-gtk
#
################################################################################

LIBDBUSMENU_GTK_VERSION = 0.4
LIBDBUSMENU_GTK_SOURCE = libdbusmenu-16.04.0.tar.gz
LIBDBUSMENU_GTK_SITE = https://launchpad.net/libdbusmenu/16.04/16.04.0/+download
LIBDBUSMENU_GTK_INSTALL_STAGING = YES
LIBDBUSMENU_GTK_LICENSE = MIT
LIBDBUSMENU_GTK_LICENSE_FILES = LICENSE
LIBDBUSMENU_GTK_DEPENDENCIES = host-pkgconf host-intltool host-coreutils libgtk3 python3 gobject-introspection json-glib
LIBDBUSMENU_GTK_AUTORECONF = YES
LIBDBUSMENU_GTK_MAKE = $(MAKE1)

LIBDBUSMENU_GTK_CONF_OPTS += -disable-static --disable-dumper --with-gtk=3

$(eval $(autotools-package))
