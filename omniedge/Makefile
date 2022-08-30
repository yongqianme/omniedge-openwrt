include $(TOPDIR)/rules.mk

PKG_NAME:=omniedge
PKG_VERSION:=0.2.3
PKG_RELEASE:=$(AUTORELEASE)
PKG_ARCH:= arm64

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-openwrt-$(PKG_ARCH).zip
PKG_SOURCE_URL:=https://github.com/omniedgeio/omniedge/releases/download/v${PKG_VERSION}/
PKG_HASH:=4392567b7e517627a59da6aa6d8a632962e3e8089f2011ebd4da1f2cfd9f3203

PKG_MAINTAINER:=omniedge <hi@omniedge.io>
PKG_LICENSE:=GPL-3.0

include $(INCLUDE_DIR)/package.mk

define Package/omniedge
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=VPN
	TITLE:=Bring intranet on the internet.What happens in intranet, stays in in intranet.
	URL:=https://github.com/omniedgeio/omniedge
endef

define Package/omniedge/description
	Bring everything into intranet.
endef

define Build/Compile
	true
endef

define Build/Configure
	true
endef

define Package/omniedge/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(CP) $(BUILD_DIR)/omniedgecli $(1)/usr/bin/omniedge
endef

$(eval $(call BuildPackage,omniedge))
