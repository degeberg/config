# The following packages need to be installed (probably others as well):
# xmonad
# dzen2
# acpi
# alsa-utils
# pavucontroller
# pidgin
# mplayer
# wpa_supplicant
# x11-xserver-utils (for xmodmap)
# xbindkeys (for shortcuts)

if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

PATH=~/.cabal/bin:$PATH

amixer -q set PCM 0

# Remaps some of the keys
xmodmap ~/.xmodmap

xbindkeys

# For locking the screen
#gnome-screensaver

# Starts KeePassX
keepassx &

# Saves DBUS
set | grep DBUS > ~/.xmonad/tempenv

# Dropbox
dropbox.py start

# start urxvt terminal daemon
urxvtd -q -f -o

setxkbmap us -variant intl

# Starts xmonad/gnome
exec ~/.cabal/bin/xmonad
