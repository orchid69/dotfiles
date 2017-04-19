#!/bin/sh

USER=satoshi
SERVER=menorca
DIR=/home/satoshi
HOME=/home/satoshi

echo "make link"
ln -s $HOME/dotfiles/.i3 .

ln -s $HOME/dotfiles/.vim .
ln -s $HOME/dotfiles/.vimrc .

ln -s $HOME/dotfiles/.vimperator .
ln -s $HOME/dotfiles/.vimperatorrc .

ln -s $HOME/dotfiles/.dircolors .

ln -s $HOME/dotfiles/.zshrc .
ln -s $HOME/dotfiles/.zaliases .

chsh -s /usr/local/bin/zsh
