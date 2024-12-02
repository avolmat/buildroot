################################################################################
#
# vkmark
#
################################################################################

VKMARK_VERSION = ab6e6f34077722d5ae33f6bd40b18ef9c0e99a15
VKMARK_SITE = $(call github,vkmark,vkmark,$(VKMARK_VERSION))
VKMARK_LICENSE = LGPL-2.1
VKMARK_LICENSE_FILES = COPYING-LGPL2.1
VKMARK_DEPENDENCIES = host-pkgconf vulkan-headers vulkan-loader glm

ifeq ($(BR2_PACKAGE_VKMARK_FLAVOR_KMS),y)
VKMARK_DEPENDENCIES += libdrm libgbm
VKMARK_CONF_OPTS += -Dkms=true
else
VKMARK_CONF_OPTS += -Dkms=false
endif

ifeq ($(BR2_PACKAGE_VKMARK_FLAVOR_WAYLAND),y)
VKMARK_DEPENDENCIES += wayland wayland-protocols
VKMARK_CONF_OPTS += -Dwayland=true
else
VKMARK_CONF_OPTS += -Dwayland=false
endif

ifeq ($(BR2_PACKAGE_VKMARK_FLAVOR_X11),y)
VKMARK_DEPENDENCIES += libxcb
VKMARK_CONF_OPTS += -Dxcb=true
else
VKMARK_CONF_OPTS += -Dxcb=false
endif

$(eval $(meson-package))
