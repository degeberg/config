#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

xsetroot -cursor_name left_ptr

keymap us
xbindkeys

urxvtd -q -f -o

eval `ssh-agent`

export LC_TIME="en_DK.UTF-8"

exec xmonad
