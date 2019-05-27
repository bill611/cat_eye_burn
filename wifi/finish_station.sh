#! /bin/sh
### BEGIN INIT INFO
# File:				finish_station.sh	
# Provides:         check if finish wifi connection 
# Author:			LEE
# Date:				2018-09-13
### END INIT INFO

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin

. /data/net_path.sh
check_ip_and_start ()
{
	status=
	while [ "$status" = "" ] 
	do
		echo "Getting ip address..."
		busybox killall -9 udhcpc
		udhcpc -n -t 10 -i wlan0 -s /etc/default.script
		wpa_cli -iwlan0 status
		status=`ifconfig wlan0 | grep "inet addr:"`
	done
}
check_finish_connect()
{
	#connect 2 min in one time
	if [ $((tcount--)) -le 0 ]
	then
		echo "Connect fail in station mode,Reconnect!"
		tcount=120
		$wifi_path/wifi_station.sh restart
		exit 0
	fi
}

first_check_status(){
	supplicant=`ps|grep wpa_supplicant`
	if [ "$supplicant" = "" ]
	then
		echo "Exit in station mode!"
		$wifi_path/wifi_station.sh restart &
		exit 0
	fi
}

#
# main:
#
first_check_status
supplicant=`ps |grep wpa_supplicant`
tcount=120
while [ "$supplicant" != "" ] 
do
	first_check_status
	stat=`wpa_cli -iwlan0 status |grep wpa_state`
	if [ "$stat" != "wpa_state=COMPLETED" ]
	then
		check_ip_and_start
		check_finish_connect
	fi
	sleep 1
	supplicant=`ps |grep wpa_supplicant`
done
