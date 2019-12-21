#!/bin/sh

/root/usr/cat_eye

if [ $? -ne 1 ] 
then
	if [ -d "/mnt/sdcard/update" ] ;then
        cd /mnt/sdcard/update
        if [ -e "go.sh" ] ;then
            ./go.sh
        else
            echo "the go.sh is not exist !!!,pleas download the new update file again!"
        fi
        rm -rf update
    fi
fi

sync

reboot
