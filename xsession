if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

amixer -q set Master 0
amixer -q set Master off

xbindkeys

# start urxvt terminal daemon
urxvtd -q -f -o

xsetroot -cursor_name left_ptr

setxkbmap us -variant intl -option terminate:ctrl_alt_bksp
xmodmap ~/.xmodmap

eval `ssh-agent`
ssh-add

start-pulseaudio-x11

xsetroot -solid black

# Starts xmonad/gnome
exec xmonad
