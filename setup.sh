#!/bin/sh

USER=satoshi
SERVER=menorca
DIR=/home/satoshi
HOME=/home/satoshi

echo "install i3"
sudo apt-get install i3

echo "install sshfs"
sudo apt-get install sshfs

echo "install zsh"
sudo apt-get install zsh

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
