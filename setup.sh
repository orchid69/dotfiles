#!/bin/sh

USER=satoshi
SERVER=menorca
#DIR=/home/satoshi
#HOME=/home/satoshi

echo "make link"
ln -s $HOME/dotfiles/.i3 $HOME

ln -s $HOME/dotfiles/.vim $HOME
ln -s $HOME/dotfiles/.vimrc $HOME

ln -s $HOME/dotfiles/.vimperator $HOME
ln -s $HOME/dotfiles/.vimperatorrc $HOME

ln -s $HOME/dotfiles/.dircolors $HOME

ln -s $HOME/dotfiles/.zshrc $HOME
ln -s $HOME/dotfiles/.zaliases $HOME

chsh -s /usr/local/bin/zsh
