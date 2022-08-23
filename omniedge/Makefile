include $(TOPDIR)/rules.mk

BUILD_ENV:= "prod"

PKG_NAME:=omniedge-cli
PKG_VERSION:=0.2.5
PKG_RELEASE:=$(AUTORELEASE)
PKG_ARCH:= arm

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://codeload.github.com/yongqianme/omniedge-cli/tar.gz/v$(PKG_VERSION)
PKG_HASH:=9120e15a93be7f643f3d8b3ba4cfe83e0176784c59df4b0846a2389468b2610a

PKG_BUILD_DEPENDS:=golang/host
PKG_BUILD_PARALLEL:=1
PKG_USE_MIPS16:=0

GO_PKG:=https://github.com/yongqianme/omniedge-cli
GO_PKG_BUILD_PKG:=https://github.com/yongqianme/omniedge-cli/out/
GO_PKG_LDFLAGS:=
GO_PKG_LDFLAGS_X:=main.Env=${BUILD_ENV}


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

# Package description; a more verbose description on what our package does
define Package/omniedge/description
  A simple "Hello, world!" -application.
endef

# Package preparation instructions; create the build directory and copy the source code.
# The last command is necessary to ensure our preparation instructions remain compatible with the patching system.
define Build/Prepare
    go.sum generate
    rm -rf ./out
endef
  
# Package build instructions; invoke the target-specific compiler to first compile the source file, and then to link the file into the final executable
define Build/Compile
    $(TARGET_CC) $(TARGET_CXX) CGO_ENABLED=1 go build -ldflags "-X main.Env=${BUILD_ENV}" -o out/omniedge cmd/edgecli/main.go
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
