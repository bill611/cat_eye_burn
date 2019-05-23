#! /bin/sh
### BEGIN INIT INFO
# Provides:          wifi soft ap
# Author:			LEE
# Date:				2018-09-13
### END INIT INFO

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin
. /data/net_path.sh
MODE=$1

set_ssid_and_password()
{
	# inifile="/mnt/nand/Net.ini"
	ssid=`busybox awk 'BEGIN {FS="="}/\[softap\]/{a=1} a==1&&$1~/s_ssid/{gsub(/\"/,"",$2);gsub(/\;.*/, "", $2);gsub(/^[[:blank:]]*/,"",$2);print $2}' $inifile`
	# ssid=`echo GM-$(cat /sys/class/net/wlan1/address | awk -F: '{printf $4 $5 $6}')`

	# sed -i "s/$Tmpssid/$ssid/g" $inifile

	password=`busybox awk 'BEGIN {FS="="}/\[softap\]/{a=1} a==1&&$1~/s_password/{gsub(/\"/,"",$2);gsub(/\;.*/, "", $2);gsub(/^[[:blank:]]*/,"",$2);print $2}' $inifile`

	$wifi_path/device_save.sh all "$ssid" $password
	echo "ssid=$ssid password=$password"
}


do_start () {
	echo "start wifi soft ap......"

	busybox insmod /root/lib/modules/cfg80211.ko
	busybox insmod /root/lib/modules/mac80211.ko
	busybox insmod /root/lib/modules/rkwifi_sys_iface.ko
	busybox insmod /root/lib/modules/bcmdhd.ko

	set_ssid_and_password
	hostapd $wifi_path/hostapd.conf -B
	test -f /var/run/udhcpd.pid && rm -f /var/run/udhcpd.pid
	test -f /var/run/dhcpd.pid && rm -f /var/run/dhcpd.pid
    # ¹Ì¶¨Îª´ËIP
	ifconfig wlan1 192.168.100.1 netmask 255.255.255.0 #for busybox
	route add default gw 192.168.100.1 #
	udhcpd $wifi_path/udhcpd.conf #for busybox
}

do_stop () {
	$wifi_path/wifi_stop.sh all
}

do_restart () {
	echo "restart wifi soft ap......"
	do_stop
	do_start
}

do_status () {
	echo "status wifi soft ap......"
}

case "$MODE" in
  start)
	do_start
	;;
  restart|reload|force-reload)
	do_restart
	;;
  stop)
	do_stop
	;;
#  status)
#	do_status
#	;;
  *)
	echo "Usage: $0 start|stop|restart"
	exit 3
	;;
esac

exit 0
