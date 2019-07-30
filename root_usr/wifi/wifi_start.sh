#! /bin/sh
### BEGIN INIT INFO
# File:				wifi_start.sh	
# Provides:         start wifi and  camera
# Author:			LEE
# Date:				2018-09-13
### END INIT INFO

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin
. /root/usr/net_path.sh
MODE=

usage()
{
	echo "Usage: $0 "
}

#
# main:
#
# inifile="/mnt/nand/Net.ini"
MODE=`busybox awk 'BEGIN {FS="="}/\[wireless\]/{a=1} a==1&&$1~/running/{gsub(/\"/,"",$2);gsub(/\;.*/, "", $2);gsub(/^[[:blank:]]*/,"",$2);print $2}' $inifile`
case "$MODE" in
	station)
		$wifi_path/wifi_station.sh start
		;;
	softap)
		$wifi_path/wifi_softap.sh start
		;;
	*)
		usage
		exit 3
		;;
esac

exit 0

