# omniedge-openwrt

OpenWrt package for [omniedge](https://github.com/omniedgeio/omniedge)

## Usage

After installing the package, login with the SECURITY_KEY and join the virtual network:

```bash
omniedge login -s <SECURITY_KEY>
omniedge join -n <VIRTUAL_NETWORK_ID>
```

Start the omniedge background service:

```bash
/etc/init.d/omniedge enable
/etc/init.d/omniedge start
```
