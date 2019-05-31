#! /bin/sh

echo "--------wifi_init.sh start--------"

mkdir -p /var/lib/misc
mkdir -p /var/run/

busybox insmod /root/lib/modules/cfg80211.ko
busybox insmod /root/lib/modules/mac80211.ko
busybox insmod /root/lib/modules/rkwifi_sys_iface.ko
busybox insmod /root/lib/modules/bcmdhd.ko

sleep 1

echo "--------wifi_init.sh exit--------"


