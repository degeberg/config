#!/bin/sh

SINK=$1
CMD=$2

BS2B_SINK="crossfeed-bs2b-$SINK"

usage() {
    (>&2 echo "usage: $0 sink [start|stop]")
    exit 1
}

sink_index() {
    pacmd list-sinks | grep 'name:.*'"$1" -B1 | grep index | awk '{ print $2 }'
}

if [ "x$SINK" = "x" ]; then
    usage
fi

case "$CMD" in
    start)
        index=$(sink_index $SINK)
        if [ "x$index" = "x" ]; then
            (>&2 echo "Sink $SINK was not found. Cannot add bs2b.")
            exit 1
        else
            pacmd load-module module-ladspa-sink sink_name="$BS2B_SINK" master="$SINK" plugin=bs2b label=bs2b control=700,4.5
        fi
        ;;
    stop)
        index=$(sink_index $BS2B_SINK)
        if [ "x$index" = "x" ]; then
            (>&2 echo "Sink $BS2B_SINK was not found. Skipping removal.")
        else
            pacmd kill-sink-input "$index"
        fi
        ;;
    *)
        usage
        ;;
esac
