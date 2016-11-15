#!/bin/sh

SINK=$1
CMD=$2

BS2B_SINK="crossfeed-bs2b-$SINK"

usage() {
    echo "usage: $0 sink [start|stop]"
    exit 1
}

if [ "x$SINK" = "x" ]; then
    usage
fi

case "$CMD" in
    start)
        pacmd load-module module-ladspa-sink sink_name="$BS2B_SINK" master="$SINK" plugin=bs2b label=bs2b control=700,4.5
        ;;
    stop)
        index=$(pacmd list-sinks | grep 'name:.*'"$BS2B_SINK" -B1 | grep index | awk '{ print $2 }')
        pacmd kill-sink-input "$index"
        ;;
    *)
        usage
        ;;
esac
