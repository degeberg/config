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

soundcontroller init

# Creates the header
dzenheader &

# Remaps some of the keys
xmodmap ~/.xmodmap

# For locking the screen
gnome-screensaver

# Starts KeePassX
keepassx &

# Saves DBUS
set | grep DBUS > ~/.xmonad/tempenv

# Dropbox
dropbox.py start

# start urxvt terminal daemon
urxvtd -q -f -o

# Starts xmonad/gnome
exec xmonad

# Make sure that dzen doesn't keep running after logout
killall dzenheader dzen2

