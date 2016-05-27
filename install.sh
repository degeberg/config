#!/bin/zsh

DIR=$(pwd)

# directories
ln -s $DIR/mplayer ~/.mplayer
mkdir -p ~/.xmonad ~/.ssh
mkdir -p ~/.config/{dunst,mpd}
mkdir -p ~/.ncmpcpp

# files
ln -s $DIR/Xdefaults ~/.Xdefaults
ln -s $DIR/xmodmap ~/.xmodmap
ln -s $DIR/xbindkeysrc ~/.xbindkeysrc
ln -s $DIR/xinitrc ~/.xinitrc
ln -s $DIR/xmobarrc ~/.xmobarrc
ln -s $DIR/pentadactylrc ~/.pentadactylrc
ln -s $DIR/xmonad/xmonad.hs ~/.xmonad/xmonad.hs
ln -s $DIR/dunstrc ~/.config/dunst/dunstrc
ln -s $DIR/ncmpcpp/config ~/.ncmpcpp/config
ln -s $DIR/mpd.conf ~/.config/mpd/mpd.conf

zsh ./install-server.sh
