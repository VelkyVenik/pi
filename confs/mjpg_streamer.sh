#!/bin/sh
# /etc/init.d/mjpg_streamer.sh
# v0.2 phillips321.co.uk
### BEGIN INIT INFO
# Provides:          mjpg_streamer.sh
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: mjpg_streamer for webcam
# Description:       Streams /dev/video0 to http://IP/?action=stream
### END INIT INFO

DIR=/usr/local/
LIB=${DIR}lib
BIN=${DIR}bin
WWW=${DIR}www

PARAMS="-n -r 960x544 -f 5"

f_message(){
        echo "[+] $1"
}

# Carry out specific functions when asked to by the system
case "$1" in
        start)
                f_message "Starting mjpg_streamer"
                mjpg_streamer -b -i "$LIB/input_uvc.so $PARAMS" -o "$LIB/output_http.so -p 8080 -w $WWW/mjpg-streamer -n"
                sleep 2
                f_message "mjpg_streamer started"
                ;;
        stop)
                f_message "Stopping mjpg_streamer..."
                killall mjpg_streamer
                f_message "mjpg_streamer stopped"
                ;;
        restart)
                f_message "Restarting daemon: mjpg_streamer"
                killall mjpg_streamer
                mjpg_streamer -b -i "$LIB/input_uvc.so $PARAMS" -o "$LIB/output_http.so -p 8080 -w $WWW/mjpg-streamer -n"
                sleep 2
                f_message "Restarted daemon: mjpg_streamer"
                ;;
        status)
                pid=`ps -A | grep mjpg_streamer | grep -v "grep" | grep -v mjpg_streamer. | awk '{print $1}' | head -n 1`
                if [ -n "$pid" ];
                then
                        f_message "mjpg_streamer is running with pid ${pid}"
                        f_message "mjpg_streamer was started with the following command line"
                        cat /proc/${pid}/cmdline ; echo ""
                else
                        f_message "Could not find mjpg_streamer running"
                fi
                ;;
        *)
                f_message "Usage: $0 {start|stop|status|restart}"
                exit 1
                ;;
esac
exit 0
