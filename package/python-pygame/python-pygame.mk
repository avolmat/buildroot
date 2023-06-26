################################################################################
#
# python-pygame
#
################################################################################

PYTHON_PYGAME_VERSION = 2.1.2
PYTHON_PYGAME_SITE = $(call github,pygame,pygame,$(PYTHON_PYGAME_VERSION))
PYTHON_PYGAME_SETUP_TYPE = setuptools
PYTHON_PYGAME_LICENSE = LGPL-2.1+
PYTHON_PYGAME_LICENSE_FILES = LGPL
PYTHON_PYGAME_DEPENDENCIES = sdl2
PYTHON_PYGAME_BUILD_OPTS = -config -auto -sdl2

ifeq ($(BR2_PACKAGE_PYTHON_PYGAME_IMAGE),y)
PYTHON_PYGAME_DEPENDENCIES += sdl2_image
endif

ifeq ($(BR2_PACKAGE_PYTHON_PYGAME_FONT),y)
PYTHON_PYGAME_DEPENDENCIES += sdl2_ttf
endif

ifeq ($(BR2_PACKAGE_PYTHON_PYGAME_MIXER),y)
PYTHON_PYGAME_DEPENDENCIES += sdl2_mixer
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
PYTHON_PYGAME_BUILD_OPTS += -enable-arm-neon
endif

PYTHON_PYGAME_ENV = \
	SDL_CONFIG="$(STAGING_DIR)/usr/bin/sdl2-config" \
	PKG_CONFIG_PATH="$(STAGING_DIR)/usr/lib/pkgconfig" \
	LOCALBASE="$(STAGING_DIR)/usr"

define PYTHON_PYGAME_REMOVE_DOC
	rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/pygame/docs
endef

PYTHON_PYGAME_POST_INSTALL_TARGET_HOOKS += PYTHON_PYGAME_REMOVE_DOC

define PYTHON_PYGAME_REMOVE_TESTS
	rm -rf $(TARGET_DIR)/usr/lib/python*/site-packages/pygame/tests
endef

PYTHON_PYGAME_POST_INSTALL_TARGET_HOOKS += PYTHON_PYGAME_REMOVE_TESTS

ifneq ($(BR2_PACKAGE_PYTHON_PYGAME_EXAMPLES),y)
define PYTHON_PYGAME_REMOVE_EXAMPLES
	rm -rf $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/pygame/examples
endef
PYTHON_PYGAME_POST_INSTALL_TARGET_HOOKS += PYTHON_PYGAME_REMOVE_EXAMPLES
endif

$(eval $(python-package))
