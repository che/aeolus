#
# Copyright (C) 2009-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=aeolus-sense
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_SOURCE:=master.tar.gz
PKG_SOURCE_URL:=https://github.com/che/aeolus/archive
PKG_SOURCE_SUBDIR:=aeolus-master

include $(INCLUDE_DIR)/package.mk

define Package/aeolus-sense
    SUBMENU:=Lua
    SECTION:=lang
    CATEGORY:=Languages
    TITLE:=AEOLUS-SENSE servers
    URL:=https://github.com/che/aeolus
    MAINTAINER:=Pavel Chebotarev <pavel.chebotarev@gmail.com>
    DEPENDS:=+lua +luasocket +luasql-sqlite3
endef

define Package/aeolus-sense/description
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef


define Package/aeolus-sense/install
endef

$(eval $(call BuildPackage,aeolus-sense))
