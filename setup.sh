#! /usr/bin/env bash

if ! [ -e ~/.npm ]; then
  sudo apt install -y npm
fi

# Create symlinks from dotfiles to home dir
ln -fs ~/dotfiles/gitconfig ~/.gitconfig

if ! [ -e ~/.vim/autoload/plug.vim ]; then
  echo "No vim-plug boo"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# hacky way of using vim bc symlinks don't automatically update
echo "source ~/dotfiles/vim/config.vim" > ~/.vimrc
