#!/bin/sh

update_dir=/tmp/update

cp -pR $update_dir/data/* /data

cp -pR $update_dir/root/* /root

sync

echo "will reboot..."

