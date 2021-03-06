export TARGET_CODESIGN_FLAGS="-Ssign.plist"
#export ARCHS = armv6
#export TARGET=iphone:5.0:4.0
export ARCHS = armv7 armv7s arm64
export TARGET=iphone:7.0:4.3
GO_EASY_ON_ME=1
include theos/makefiles/common.mk

TOOL_NAME = ipainstaller
ipainstaller_FILES = ZipArchive/ZipArchive.mm UIDevice-Capabilities/UIDevice-Capabilities.m main.mm
ipainstaller_FRAMEWORKS = Foundation UIKit
ipainstaller_PRIVATE_FRAMEWORKS = GraphicsServices
ipainstaller_CFLAGS = -I./ZipArchive/minizip
ipainstaller_LDFLAGS = -MobileInstallation -lz
ipainstaller_INSTALL_PATH = /usr/bin
ipainstaller_SUBPROJECTS = ZipArchive/minizip

include theos/makefiles/tool.mk

before-package::
	ln -s ipainstaller _/usr/bin/installipa
	touch -r _/usr/bin/ipainstaller _
	touch -r _/usr/bin/ipainstaller _/DEBIAN
	touch -r _/usr/bin/ipainstaller _/DEBIAN/*
	touch -r _/usr/bin/ipainstaller _/usr
	touch -r _/usr/bin/ipainstaller _/usr/bin
	touch -r _/usr/bin/ipainstaller _/usr/bin/installipa.sh
	chmod 0755 _/usr/bin/installipa.sh _/usr/bin/ipainstaller*

after-package::
	rm -fr .theos/packages/*
