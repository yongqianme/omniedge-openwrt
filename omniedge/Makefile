include $(TOPDIR)/rules.mk

PKG_NAME:=omniedge
PKG_VERSION:=0.2.3
PKG_RELEASE:=$(AUTORELEASE)

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/omniedgeio/omniedge/releases/tag/v$(PKG_VERSION)?
PKG_HASH:=9120e15a93be7f643f3d8b3ba4cfe83e0176784c59df4b0846a2389468b2610a

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=https://github.com/omniedgeio/omniedge-cli
GO_PKG_BUILD_PKG:=https://github.com/omniedgeio/omniedge-cli/out/
GO_PKG_LDFLAGS:=-s -w
GO_PKG_LDFLAGS_X:=main.Version=v$(PKG_VERSION)

include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/packages/lang/golang/golang-package.mk

define Package/omniedge
  SECTION:=net
  CATEGORY:=Network
  SUBMENU:=VPN
  TITLE:=Bring intranet on the internet.What happens in intranet, stays in in intranet
  URL:=https://github.com/omniedgeio/omniedge
  DEPENDS:=$(GO_ARCH_DEPENDS)
endef

define Package/omniedge/install
	$(call GoPackage/Package/Install/Bin,$(PKG_INSTALL_DIR))

	$(INSTALL_DIR) $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/client $(1)/usr/bin/omniedge

	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_BIN) $(CURDIR)/files/omniedge.init $(1)/etc/init.d/omniedge
endef

$(eval $(call GoBinPackage,omniedge))
$(eval $(call BuildPackage,omniedge))
