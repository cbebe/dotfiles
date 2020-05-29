#! /usr/bin/env bash
# Create symlinks from dotfiles to home dir
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig
ln -fs ~/dotfiles/.bashrc ~/.bashrc
ln -fs ~/dotfiles/.bash_profile ~/.bash_profile
# hacky way of using vim bc symlinks don't automatically update
echo "source ~/dotfiles/.vim/.vimrc" > ~/.vimrc
