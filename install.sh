#!/bin/bash

DIR=$(pwd)

# directories
ln -s $DIR/mplayer ~/.mplayer
mkdir -p ~/.xmonad ~/.ssh
mkdir -p ~/.config/dunst

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
ln -s $DIR/ssh/config ~/.ssh/config
ln -s $DIR/dunstrc ~/.config/dunst/dunstrc

# vim
ln -s $DIR/vim ~/.vim
ln -s $DIR/vimrc ~/.vimrc
if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

# other
ln -s ~/.xsession ~/.xinitrc

# other config repositories
cd ~/projects

if [ ! -d LS_COLORS ]; then
    git clone https://github.com/trapd00r/LS_COLORS.git
fi

if [ ! -d zsh-syntax-highlighting-filetypes ]; then
    git clone https://github.com/trapd00r/zsh-syntax-highlighting-filetypes.git
fi

if [ ! -d oh-my-zsh ]; then
    git clone git://github.com/degeberg/oh-my-zsh.git
fi
