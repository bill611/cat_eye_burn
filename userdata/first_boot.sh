#!/bin/sh
export LD_LIBRARY_PATH=/lib:/root/lib
export PATH=/bin:/sbin:/usr/local/bin:/usr/local/sbin:/root/bin:/root/sbin:/data

### tslib env
source /etc/ts_env.sh

/data/singlechip &
/data/cammer_video &

