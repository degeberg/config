#!/bin/sh

function usage() {
    >&2 echo "usage: $0 lock_command"
    >&2 echo ""
    >&2 echo "The lock_command needs to be blocking until the screen is unlocked."
    >&2 echo ""
    >&2 echo "This wrapper is designed to add dbus notifications to screen lock"
    >&2 echo "programs that do not support it natively."
    exit 1
}

function send() {
    dbus-send \
        --session \
        --dest=org.freedesktop.ScreenSaver \
        --type=signal \
        /ScreenSaver \
        org.freedesktop.ScreenSaver.Lock \
        boolean:$1
}

if [ "$#" -eq 0 ]; then
    usage
fi

send true
sh -c "$@"
send false
