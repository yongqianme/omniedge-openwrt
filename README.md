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

#!/bin/bash bash
#Interface

#Peer


# #!/bin/sh
# on=$(cat /sys/devices/soc:xg-utility/status)
# if [ "$on" = "0" ]; then
# echo "{\"GL-MIFI\":\"offline\"}" > /tmp/jb_GL-MIFI.json
# exit 1
# fi
# ip link add dev GL-MIFI type wireguard
# ip address add dev GL-MIFI $Address
# wg set GL-MIFI listen-port 51820 private-key $PrivateKey peer $PublicKey persistent-keepalive $PersistentKeepalive allowed-ips $AllowedIPs endpoint $Endpoint
# ip link set up dev GL-MIFI
# echo "{\"GL-MIFI\":\"online\"}" > /tmp/jb_GL-MIFI.json
# sleep 2
# iptables -I FORWARD 1 -i $LAN_DEV -d 192.168.255.0/24 -j ACCEPT

LAN_DEV=`ubus call network.interface.lan status | jsonfilter -e '@["device"]'`
OMNIEDGE_IF="GLMIFI"
# Configure firewall
uci rename firewall.@zone[0]="lan"
uci rename firewall.@zone[1]="wan"
uci rename firewall.@forwarding[0]="lan_wan"
uci del_list firewall.wan.network="${OMNIEDGE_IF}"
uci add_list firewall.wan.network="${OMNIEDGE_IF}"

#添加接口到LAN桥中
uci set network.lan.ifname="$(uci get network.lan.ifname) ${OMNIEDGE_IF}"

#允许客户端的进口的流量输入
uci set firewall.Allow_GLMIFI_Inbound=rule
uci set firewall.Allow_GLMIFI_Inbound.target=ACCEPT
uci set firewall.Allow_GLMIFI_Inbound.src=*

# Configure network
uci -q delete network.${OMNIEDGE_IF}
uci set network.${OMNIEDGE_IF}="interface"
 
#开启192.168.8.0 转发
iptables -I FORWARD -s 192.168.8.0/24 -j ACCEPT
# iptables -I FORWARD 1 -i $LAN_DEV -d 192.168.255.0/24 -j ACCEPT

uci commit firewall
uci commit network
/etc/init.d/firewall restart && /etc/init.d/network restart
