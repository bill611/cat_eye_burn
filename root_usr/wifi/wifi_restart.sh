#! /bin/sh
##
# File:				wifi_restart.sh	
# Provides:         start wifi and  camera
# Author:			LEE
# Date:				2018-11-05
##

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

#WIFI stop all
$wifi_path/wifi_stop.sh all
sleep 1
#WIFI start
$wifi_path/wifi_start.sh

exit 0

