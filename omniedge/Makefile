include $(TOPDIR)/rules.mk

PKG_NAME:=omniedge
PKG_VERSION:=$$(OMNIEDGE_VERSION)
PKG_RELEASE:=$(AUTORELEASE)
PKG_ARCH:= $$(ARCH)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-openwrt-$$(ARCH).zip
PKG_SOURCE_URL:=https://github.com/omniedgeio/omniedge-cli/releases/download/${PKG_VERSION}
PKG_HASH:=$$(HASH256)

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
	$(CP) $(BUILD_DIR)/omniedge $(1)/usr/bin/omniedge

	$(INSTALL_DIR) $(1)/etc/init.d/
	$(CP) $(CURDIR)/files/omniedge.init $(1)/etc/init.d/omniedge

	$(INSTALL_DIR) $(1)/etc/
	$(CP) $(CURDIR)/files/omniedge $(1)/etc/
endef

$(eval $(call BuildPackage,omniedge))
