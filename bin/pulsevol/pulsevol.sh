#!/bin/bash

STEP='2dB'

default_sink=$(pacmd list-sinks | awk '/* index:/{ print $3 }')
pipe=/tmp/.xmobar-volume-pipe

function is_muted {
    pacmd list-sinks | grep -A 15 '* index' | awk '/muted:/{ print $2 }'
}

function get_volume {
    pacmd list-sinks | grep -A 15 '* index' | awk '/volume: front/{ print $7 }' | sed 's/^-0.00$/0.00/'
}

function volume_xmobar {
    if [ "$(is_muted)" == "no" ]; then
        echo -n "<fc=green><icon=spkr_01.xbm/></fc>"
    else
        echo -n "<icon=spkr_02.xbm/>"
    fi
    echo " $(get_volume) dB"
}

function update_pipe {
    [[ -p $pipe ]] || mkfifo --mode='u=rw,og=' $pipe
    volume_xmobar > $pipe
}

case "$1" in
    "up")
        if [ "$(get_volume)" == "-inf" ]; then
            pactl set-sink-volume $default_sink 0dB
            pactl set-sink-volume $default_sink \-60dB
        else
            pactl set-sink-volume $default_sink +$STEP
        fi
        update_pipe
        ;;
    "down")
        pactl set-sink-volume $default_sink \-$STEP
        update_pipe
        ;;
    "set-volume")
        pactl set-sink-volume $default_sink $2
        update_pipe
        ;;
    "mute")
        pactl set-sink-mute $default_sink 1
        update_pipe
        ;;
    "unmute")
        pactl set-sink-mute $default_sink 0
        update_pipe
        ;;
    "mute-toggle")
        pactl set-sink-mute $default_sink toggle
        update_pipe
        ;;
    "muted")
        is_muted
        ;;
    "volume")
        echo "$(get_volume) dB"
        ;;
    "volume-xmobar")
        volume_xmobar
        ;;
    "update-pipe")
        secs=$2
        [[ "x$secs" != "x" ]] || exit 1
        while :; do
            update_pipe
            sleep $secs
        done
        ;;
esac
