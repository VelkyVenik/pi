#!/bin/bash

cd $(dirname $(readlink -f $0))

. config.sh
. utils.sh

script_start $*

FILE=$(date +%Y%m%d%H%M).jpg

if [ "$CAMERA_CHECK_WEMO" -eq 1 ]; then
	./wemo.sh remote_status
	RETVAL=$?
	if [ "$RETVAL" -ne 1 ]; then
		debug "Light is off, no camera shots..."
		script_end
		exit -1
	fi
fi

debug "Taking camera shot: $FILE"
wget $CAMERA_SHOT_URL -O - -a ${LOGDIR}/camera-shot.log | convert - -transpose -transpose -rotate 180 ${SHOTSDIR}/${FILE}

debug "Copying file to remote location"
cp ${SHOTSDIR}/${FILE} /mnt/home/Dropbox/Photos/Chilli

script_end
 
