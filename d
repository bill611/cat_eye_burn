#!/bin/sh

mkdir -p /temp
ifconfig wlan0:1 172.16.1.2 netmask 255.255.0.0
if [ ! -e "/temp/v" ] ;then
	echo "mounting ..."
	mount -t nfs -o nolock 172.16.1.102:/home/xubin/work/arm_share/cat_eye /temp
fi

if [ $# == 1  ]; then
	echo "cp /temp/v ."
	cp /temp/v .
	./v
fi


