#!/bin/bash

. config.sh


# create directories
mkdir -p $DIR
mkdir -p $BINDIR
mkdir -p $DATADIR
mkdir -p $SHOTSDIR
mkdir -p $LOGDIR

# fix permissions
chmod +x *.sh
chown -R pi $DIR
