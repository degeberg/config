#!/bin/zsh

DIR=$(pwd)

# directories
ln -s $DIR/mplayer ~/.mplayer
mkdir -p ~/.xmonad ~/.ssh
mkdir -p ~/.config/{dunst,mpd,gtk-3.0}
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
ln -s $DIR/gtk/gtk2/gtkrc-2.0 ~/.gtkrc-2.0
ln -s $DIR/gtk/gtk2/gtkrc-2.0.mine ~/.gtkrc-2.0.mine
ln -s $DIR/gtk/gtk3/settings.ini ~/.config/gtk-3.0/settings.ini
ln -s $DIR/redshift.conf ~/.config/redshift.conf

# systemd
mkdir -p ~/.config/systemd/user
ln $DIR/systemd/compton.service ~/.config/systemd/user/compton.service
systemctl --user daemon-reload
#systemctl --user enable compton.service

zsh ./install-server.sh
