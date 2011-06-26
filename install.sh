#!/bin/sh

DIR=`pwd`

# directories
ln -s $DIR/mplayer ~/.mplayer
mkdir -p ~/.xmonad

# files
ln -s $DIR/Xdefaults ~/.Xdefaults
ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/xmodmap ~/.xmodmap
ln -s $DIR/xbindkeysrc ~/.xbindkeysrc
ln -s $DIR/xsession ~/.xsession
ln -s $DIR/gitconfig ~/.gitconfig
ln -s $DIR/screenrc ~/.screenrc
ln -s $DIR/xmobarrc ~/.xmobarrc
ln -s $DIR/pentadactylrc ~/.pentadactylrc
ln -s $DIR/xmonad/xmonad.hs ~/.xmonad/xmonad.hs

# other
ln -s ~/.xsession ~/.xinitrc

# other config repositories
cd ~/projects

git clone git://github.com/degeberg/startervim.git
(cd startervim; ./install.sh)

git clone git://github.com/degeberg/oh-my-zsh.git
(cd oh-my-zsh; ./install.sh)
