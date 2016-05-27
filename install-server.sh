#!/bin/zsh

DIR=$(pwd)

# files
ln -s $DIR/gitconfig ~/.gitconfig
ln -s $DIR/screenrc ~/.screenrc
ln -s $DIR/ssh/config ~/.ssh/config
ln -s $DIR/ghci ~/.ghci

# vim
ln -s $DIR/vim ~/.vim
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/vim ~/.config/nvim
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
rm -f ~/.zlogout
wget https://files.degeberg.com/prompt_superlinh_setup -O ~/.zprezto/modules/prompt/functions/prompt_superlinh_setup
