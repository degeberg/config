if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

amixer -q set Master 0
amixer -q set Master off
amixer -c 0 -q set Speaker 0

xbindkeys

# Dropbox
dropbox.py start

# start urxvt terminal daemon
urxvtd -q -f -o

xsetroot -cursor_name left_ptr

setxkbmap us -variant intl -option terminate:ctrl_alt_bksp
xmodmap ~/.xmodmap

eval `ssh-agent`

start-pulseaudio-x11

#/usr/lib/notification-daemon-1.0/notification-daemon &
dunst -geometry x5 -to 5 -format "%s: %b" &

/usr/share/android-notifier-desktop/run.sh -t &

if [ -f ~/background.jpg ]; then
    feh --bg-scale ~/background.jpg
fi

# Starts xmonad/gnome
exec ck-launch-session xmonad
