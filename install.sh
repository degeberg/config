#!/bin/bash

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
ln -s $DIR/gitconfig ~/.gitconfig
ln -s $DIR/screenrc ~/.screenrc
ln -s $DIR/xmobarrc ~/.xmobarrc
ln -s $DIR/pentadactylrc ~/.pentadactylrc
ln -s $DIR/xmonad/xmonad.hs ~/.xmonad/xmonad.hs
ln -s $DIR/ssh/config ~/.ssh/config
ln -s $DIR/dunstrc ~/.config/dunst/dunstrc
ln -s $DIR/ncmpcpp/config ~/.ncmpcpp/config
ln -s $DIR/ghci ~/.ghci
ln -s $DIR/mpd.conf ~/.config/mpd/mpd.conf

# vim
ln -s $DIR/vim ~/.vim
ln -s $DIR/vimrc ~/.vimrc
if [ ! -d ~/.vim/bundle/vundle ]; then
    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi

# other config repositories
cd ~/projects

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
ln -sf $DIR/zshrc ~/.zshrc
ln -sf $DIR/zpreztorc ~/.zpreztorc
