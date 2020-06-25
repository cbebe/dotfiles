#! /usr/bin/env bash

# install zsh
if ! [ -e ~/.zshrc ]; then
  echo "No zsh boo"
  sudo apt install -y zsh curl
  chsh -s /bin/zsh ${USER}
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# install tmux
if ! [ -e ~/.tmux.conf ]; then
  echo "No tmux boo"
  sudo apt install -y tmux
fi

# Create symlinks from dotfiles to home dir
ln -fs ~/dotfiles/gitconfig ~/.gitconfig
ln -fs ~/dotfiles/zshrc ~/.zshrc
ln -fs ~/dotfiles/tmux.conf ~/.tmux.conf
if ! [ -e ~/.vim/autoload/plug.vim ]; then
  echo "No vim-plug boo"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
# hacky way of using vim bc symlinks don't automatically update
echo "source ~/dotfiles/vim/config.vim" > ~/.vimrc
# getting zsh aliases for nvim
echo "source ~/dotfiles/zsh_aliases" > ~/.zshenv
