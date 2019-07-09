include $(THEOS)/makefiles/common.mk

ARCHS = arm64 arm64e armv7
TWEAK_NAME = tweakcompatiblezebra
tweakcompatiblezebra_FILES = Tweak.xm
tweakcompatiblezebra_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
