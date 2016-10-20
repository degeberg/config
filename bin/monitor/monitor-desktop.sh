#!/bin/bash

function usage() {
	echo "usage: $0 pc|tv|both|mirror"
	exit 1
}

if [ "$#" == "0" ]; then
    usage
fi

MODE=$1

OUTPUT_TV="DP-1"
OUTPUT_PC="HDMI-0"

case "$MODE" in
    pc)
        xrandr --output $OUTPUT_PC --auto --primary --output $OUTPUT_TV --off
        xset +dpms
        xset s on
        #systemctl --user restart redshift &
        ;;
    tv)
        xrandr --output $OUTPUT_TV --auto --primary --output $OUTPUT_PC --off
        xset -dpms
        xset s off
        #systemctl --user stop redshift
        ;;
    both)
        xrandr --output $OUTPUT_PC --auto --primary --output $OUTPUT_TV --auto --left-of $OUTPUT_PC
        xset -dpms
        xset s off
        #systemctl --user restart redshift &
        ;;
    mirror)
        xrandr --output $OUTPUT_PC --auto --output $OUTPUT_TV --auto --same-as $OUTPUT_PC
        xset +dpms
        xset s on
        #systemctl --user restart redshift &
        ;;
    *)
        usage
        ;;
esac
