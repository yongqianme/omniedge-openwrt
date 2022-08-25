# omniedge-openwrt

OpenWrt package for [omniedge](https://github.com/omniedgeio/omniedge)

[arm_cortex-a7_neon-vfpv4](https://openwrt.org/docs/techref/instructionset/arm_cortex-a7_neon-vfpv4)

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
