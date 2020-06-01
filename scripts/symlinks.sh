#! /usr/bin/env bash
# Create symlinks from dotfiles to home dir
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig
ln -fs ~/dotfiles/.zshrc ~/.zshrc
# hacky way of using nvim bc symlinks don't automatically update
echo "source ~/dotfiles/nvim/init.vim" > ~/.config/nvim/init.vim
