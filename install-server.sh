#!/bin/zsh

DIR=$(pwd)

# files
ln -s $DIR/gitconfig ~/.gitconfig
ln -s $DIR/screenrc ~/.screenrc
ln -s $DIR/ssh/config ~/.ssh/config
ln -s $DIR/ghci ~/.ghci
ln -s $DIR/zimrc ~/.zimrc

# vim
ln -s $DIR/vim ~/.vim
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/vim ~/.config/nvim
#if [ ! -d ~/.vim/bundle/vundle ]; then
#    git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
#fi
