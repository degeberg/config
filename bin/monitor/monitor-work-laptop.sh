#!/bin/bash

function usage() {
	echo "usage: $0 pc|dock"
	exit 1
}

if [ "$#" == "0" ]; then
    usage
fi

MODE=$1

OUTPUT_MON1="DP2-3"
OUTPUT_MON2="DP2-2"
OUTPUT_PC="eDP1"

case "$MODE" in
    pc)
        xrandr --output $OUTPUT_PC --auto --primary \
            --output $OUTPUT_MON1 --off \
            --output $OUTPUT_MON2 --off
        ;;
    dock)
        xrandr --output $OUTPUT_PC --auto --left-of $OUTPUT_MON1 \
            --output $OUTPUT_MON1 --auto --primary \
            --output $OUTPUT_MON2 --auto --right-of $OUTPUT_MON1
        ;;
    *)
        usage
        ;;
esac

xset s on
xset +dpms
