#!/bin/sh

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

amixer -q set Master 0
amixer -q set Master off

xbindkeys

# Dropbox
dropbox start

# start urxvt terminal daemon
urxvtd -q -f -o

xsetroot -cursor_name left_ptr

setxkbmap us -variant intl -option terminate:ctrl_alt_bksp
xmodmap ~/.xmodmap

eval `ssh-agent`

start-pulseaudio-x11

#compton -cC -fF -I 0.065 -O 0.065 -D 6 -m 0.8 -i 1 -e 0.6 -b
#feh --bg-scale ~/black.png
dunst &

#/usr/share/android-notifier-desktop/run.sh -t &

background

#gtk-redshift -l 55.7:12.6 &

export LEDGER=~/regnskab/regnskab.journal

arbtt-capture --sample-rate=10 &

# Starts xmonad/gnome
exec xmonad
