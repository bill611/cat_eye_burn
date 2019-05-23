#! /bin/sh
### BEGIN INIT INFO
# File:				wifi_stop.sh	
# Provides:         stop wifi 
# Short-Description:stop wifi connet service
# Author:			LEE
# Date:				2018-09-13
### END INIT INFO

MODE=$1
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin

usage()
{
	echo "Usage: $0 mode(all|station|softap)"
	exit 3
}

stop_station()
{
	echo "stop wifi station......"
	busybox killall -9 wpa_supplicant
	busybox killall -9 udhcpc
}

stop_softap ()
{
	echo "stop wifi soft ap......"
	busybox killall -9 udhcpd
	busybox killall -9 hostapd
}

stop_module ()
{
		busybox rmmod /root/lib/modules/cfg80211.ko
		busybox rmmod /root/lib/modules/mac80211.ko
		busybox rmmod /root/lib/modules/rkwifi_sys_iface.ko
		busybox rmmod /root/lib/modules/bcmdhd.ko
}


#
# main:
#

case "$MODE" in
	all)
		stop_station
		stop_softap
		stop_module	
		;;
	station)
		stop_station
		stop_module	
		;;
	softap)
		stop_softap	
		stop_module	
		;;
	*)
		usage
		;;
esac

exit 0

