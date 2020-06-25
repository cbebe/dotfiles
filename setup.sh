#! /usr/bin/env bash

# install zsh
if ! [[ -e ~/.zshrc ]]; then
  echo "No zsh boo"
  sudo apt install -y zsh curl
  chsh -s /bin/zsh ${USER}
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Create symlinks from dotfiles to home dir
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig
ln -fs ~/dotfiles/.zshrc ~/.zshrc
# hacky way of using vim bc symlinks don't automatically update
echo "source ~/dotfiles/vim/.vimrc" > ~/.vimrc
# getting zsh aliases for nvim
echo "source ~/dotfiles/.zsh_aliases" > ~/.zshenv
