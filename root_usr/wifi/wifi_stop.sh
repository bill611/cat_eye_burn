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

stop_shell()
{
	busybox killall finish_station.sh
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

#
# main:
#

case "$MODE" in
	all)
		stop_shell
		stop_station
		stop_softap
		;;
	station)
		stop_shell
		stop_station
		;;
	softap)
		stop_shell
		stop_softap	
		;;
	*)
		usage
		;;
esac

exit 0

