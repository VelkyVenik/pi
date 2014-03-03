#!/bin/bash

. config.sh
. utils.sh

script_start $*

F="${DATADIR}/wemo-${WEMO_NAME}-on"
RETVAL=0

function turn_on ()
{
	debug "Turn wemo $WEMO_NAME on"
	if [ -e "$F" ]; then
		warn "device is already on"
	fi
	#wemo $WEMO_NAME on
	touch $F
}

function turn_off()
{
	debug "Turn wemo $WEMO_NAME off"
	if [ ! -e "$F" ]; then
		warn "device is already off"
	fi
	#wemo $WEMO_NAME off
	rm -f $F
}

function check_status()
{
	debug "Check wemo $WEMO_NAME status"
	if [ -e "$F" ]; then
		debug "status: on"
		RETVAL=1
	else
		debug "status: off"
		RETVAL=0
	fi
}

STATUS=$1
if [ -z "$STATUS" ]; then
	echo "missing status parametr [on|off]"
	exit -1
fi

if [ "$STATUS" = "on" ]; then
	turn_on
elif [ "$STATUS" = "off" ]; then
	turn_off
elif [ "$STATUS" = "status" ]; then
	check_status
else
	echo "unknown parametr: $STATUS"
	RETVAL=-1
fi

debug "Return value: $RETVAL"

script_end

exit $RETVAL

