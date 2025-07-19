TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = CtrlKit

CtrlKit_FILES = CtrlKit.m IPCObserver.m
CtrlKit_PUBLIC_HEADERS = CtrlKit.h IPCObserver.h
CtrlKit_INSTALL_PATH = /Library/Frameworks
CtrlKit_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/framework.mk
