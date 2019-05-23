#! /bin/sh
### BEGIN INIT INFO
# File:				wifi_station.sh	
# Provides:         start and exit wifi station mode 
# Required-Start:   $
# Required-Stop:
# Default-Start:     
# Default-Stop:
# Short-Description:start and stop wifi station
# Author:			gao_wangsheng
# Email: 			gao_wangsheng@anyka.oa
# Date:				2012-8-2
### END INIT INFO

MODE=$1
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin
. /data/net_path.sh

usage()
{
	echo "Usage: $0 mode(start|stop)"
	exit 3
}

stop_station()
{
	echo "stop wifi station......"
	$wifi_path/wifi_stop.sh all
}

get_ini_value_and_connect()
{
	# inifile="/mnt/nand/Net.ini"

	ssid=`busybox awk 'BEGIN {FS="="}/\[wireless\]/{a=1} a==1&&$1~/^ssid/{gsub(/\"/,"",$2);gsub(/\;.*/, "", $2);gsub(/^[[:blank:]]*/,"",$2);print $2}' $inifile`
	mode=`busybox awk 'BEGIN {FS="="}/\[wireless\]/{a=1} a==1&&$1~/^mode/{gsub(/\"/,"",$2);gsub(/\;.*/, "", $2);gsub(/^[[:blank:]]*/,"",$2);print $2}' $inifile`
	security=`busybox awk 'BEGIN {FS="="}/\[wireless\]/{a=1} a==1&&$1~/^security/{gsub(/\"/,"",$2);gsub(/\;.*/, "", $2);gsub(/^[[:blank:]]*/,"",$2);print $2}' $inifile`
	password=`busybox awk 'BEGIN {FS="="}/\[wireless\]/{a=1} a==1&&$1~/^password/{gsub(/\"/,"",$2);gsub(/\;.*/, "", $2);gsub(/^[[:blank:]]*/,"",$2);print $2}' $inifile`

	if [ "$mode" = "Ad-Hoc" ] || [ "`echo $mode|grep -i "hoc"`" != "" ]
	then
		security=adhoc
	elif [ "$security" = "NONE" ] || [ "`echo $security|grep -i "none"`" != "" ]
	then
		security=open
	elif [ "$security" = "WEP" ] || [ "`echo $security|grep -i "wep"`" != "" ]
	then
		security=wep
	else
		security=wpa
	fi
	
	echo "security=$security ssid=$ssid password=$password"
	$wifi_path/wifi_connect.sh $security "$ssid" "$password"
}

start_station ()
{
	echo "start wifi station......"
	get_ini_value_and_connect
}


#
# main:
#

case "$MODE" in
	start)
		start_station	
		;;
	stop)
		stop_station
		;;
	restart)
		stop_station
		start_station	
		;;
	*)
		usage
		;;
esac
echo "------------------------------------"
echo "------------------------------------"
echo "wifi_station.sh exit"
echo "------------------------------------"
echo "------------------------------------"
exit 0

