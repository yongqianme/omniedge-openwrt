include $(TOPDIR)/rules.mk

PKG_NAME:=omniedge
PKG_VERSION:=0.2.3
PKG_RELEASE:=$(AUTORELEASE)
PKG_ARCH:= mipsle

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION)-openwrt-$(PKG_ARCH).zip
PKG_SOURCE_URL:=https://github.com/omniedgeio/omniedge/releases/download/v0.2.3/
PKG_HASH:=cbc6cbb1b68447e89766576fd54b8dd82fdeb0527cd3339ca613c18c0de1421a
PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)

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
	$(INSTALL_DIR) $(1)/bin
	$(CP) $(PKG_BUILD_DIR)/$(PKG_NAME) $(1)/bin/
endef

$(eval $(call BuildPackage,omniedge))
