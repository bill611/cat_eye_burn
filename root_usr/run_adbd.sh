#! /bin/sh

echo RockChip > /sys/class/android_usb/android0/iManufacturer
echo RV1108 > /sys/class/android_usb/android0/iProduct

busybox mkdir -p /dev/usb-ffs/adb
busybox mount -t functionfs adb /dev/usb-ffs/adb

echo 0 > /sys/class/android_usb/android0/enable
echo adb > /sys/class/android_usb/android0/f_ffs/aliases
echo 2207 > /sys/class/android_usb/android0/idVendor
echo 0006 > /sys/class/android_usb/android0/idProduct
echo adb > /sys/class/android_usb/android0/functions
echo 1 > /sys/class/android_usb/android0/enable

while true; do
	server=`busybox ps aux | busybox grep adbd | busybox grep -v grep`
	if [ ! "$server" ]; then
		/usr/local/sbin/adbd  &
		echo "run adbd"
		busybox sleep 1
	fi
	busybox sleep 1
done
