if [ -d $HOME/bin ]; then
    PATH=$HOME/bin:$PATH
fi

PATH=~/.cabal/bin:$PATH

amixer -q set PCM 0
xbindkeys

# Dropbox
dropbox.py start

# start urxvt terminal daemon
urxvtd -q -f -o

setxkbmap us -variant intl
xmodmap ~/.xmodmap

# Starts xmonad/gnome
exec ~/.cabal/bin/xmonad
