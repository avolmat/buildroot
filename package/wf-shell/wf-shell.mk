################################################################################
#
# wf-shell
#
################################################################################

WF_SHELL_VERSION = 0.9.0
WF_SHELL_SOURCE = wf-shell-$(WF_SHELL_VERSION).tar.xz
WF_SHELL_SITE = https://github.com/WayfireWM/wf-shell/releases/download/v$(WF_SHELL_VERSION)
WF_SHELL_INSTALL_STAGING = YES
WF_SHELL_LICENSE = MIT
WF_SHELL_LICENSE_FILES = LICENSE
WF_SHELL_DEPENDENCIES = host-pkgconf host-vala wayfire gtkmm3 libgtk3 \
			python3 gobject-introspection libdbusmenu-gtk
WF_SHELL_CONF_OPTS = \
	-Dwerror=false

$(eval $(meson-package))
