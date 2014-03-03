#!/bin/bash

function script_start()
{
	debug "Start: $0, params($#) $*"
}

function script_end()
{
	debug "End: $0"
}

function debug()
{
	if [ "$DEBUG" -eq "1" ]; then
		echo $1
	fi
}

function warn()
{
	echo $1
}

