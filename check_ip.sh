#!/bin/sh

# Íø¿¨Ãû×Ö eth0 or wlan0
net_type=wlan0
save_file=/data/net_status


/data/wifi/wifi_start.sh &

while [ 1 ]; do
    IsNetRun=`cat /sys/class/net/$net_type/carrier`
    if [ "$IsNetRun" == "1" ]; then
        echo "connect=1" > $save_file
    else
        echo "connect=0" > $save_file
    fi
    sleep 1
done
