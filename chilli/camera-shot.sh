#!/bin/bash

. config.sh
. utils.sh

script_start $*

FILE=$(date +%Y%m%d%H%M).jpg

wget $CAMERA_SHOT_URL -O - -a ${LOGDIR}/camera-shot.log | convert - -transpose -transpose -rotate 180 ${SHOTSDIR}/${FILE}

cp ${SHOTSDIR}/${FILE} /mnt/home/Dropbox/Photos/Chilli

script_end
 
