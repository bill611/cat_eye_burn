#! /bin/sh

mkdir -p /var/lib/misc
mkdir -p /var/run/

busybox insmod /root/lib/modules/cfg80211.ko
busybox insmod /root/lib/modules/mac80211.ko
busybox insmod /root/lib/modules/rkwifi_sys_iface.ko
busybox insmod /root/lib/modules/bcmdhd.ko

sleep 1

echo "------------------------------------"
echo "------------------------------------"
echo "wifi_wifi.sh exit"
echo "------------------------------------"
echo "------------------------------------"
exit 0


