#!/bin/bash

DEBUG=1

DIR=/opt/chilli

BINDIR=${DIR}/bin
DATADIR=${DIR}/data
SHOTSDIR=${DIR}/camera
LOGDIR=${DIR}/log

# Wemo configuration
WEMO_NAME=chilli

# Camera configuration
CAMERA_SHOT_URL="http://192.168.88.7:8080/?action=snapshot"
CAMERA_STREAM_URL=""
