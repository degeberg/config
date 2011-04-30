if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

amixer -q set Master 0
amixer -q set Speaker 0
xbindkeys

# Dropbox
dropbox.py start

# start urxvt terminal daemon
urxvtd -q -f -o

xsetroot -cursor_name left_ptr

setxkbmap us -variant intl
xmodmap ~/.xmodmap

eval `ssh-agent`

start-pulseaudio-x11

# Starts xmonad/gnome
exec xmonad
