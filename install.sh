#!/bin/sh

DIR=`pwd`

# directories
ln -s $DIR/vim ~/.vim
ln -s $DIR/mplayer ~/.mplayer
mkdir -p ~/.xmonad

# files
ln -s $DIR/Xdefaults ~/.Xdefaults
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/gvimrc ~/.gvimrc
ln -s $DIR/zshrc ~/.zshrc
ln -s $DIR/xmodmap ~/.xmodmap
ln -s $DIR/xbindkeysrc ~/.xbindkeysrc
ln -s $DIR/xsession ~/.xsession
ln -s $DIR/gitconfig ~/.gitconfig
ln -s $DIR/screenrc ~/.screenrc
ln -s $DIR/xmobarrc ~/.xmobarrc
ln -s $DIR/xmonad/xmonad.hs ~/.xmonad/xmonad.hs

# other
ln -s ~/.xsession ~/.xinitrc
