#!/bin/bash

. config.sh
. utils.sh

script_start $*

F="${DATADIR}/wemo-${WEMONAME}-on"

function turn_on ()
{
	debug "Turn wemo $WEMONAME on"
	if [ -e "$F" ]; then
		warn "device is already on"
	fi
	#wemo $WEMONAME on
	touch $F
}

function turn_off()
{
	debug "Turn wemo $WEMONAME off"
	if [ ! -e "$F" ]; then
		warn "device is already off"
	fi
	#wemo $WEMONAME off
	rm -f $F
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
else
	echo "unknown parametr: $STATUS"
fi

script_end
