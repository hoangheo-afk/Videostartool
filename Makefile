ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = VideoStar

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = VideoStarTool
VideoStarTool_FILES = Tweak.x
VideoStarTool_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable
VideoStarTool_FRAMEWORKS = UIKit Foundation StoreKit CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk
