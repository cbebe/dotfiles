#! /usr/bin/env bash

# install zsh
if ! [[ -e ~/.zshrc ]]; then
  echo "No zsh boo"
  sudo apt install -y zsh curl
  chsh -s /bin/zsh ${USER}
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi
# install neovim
if ! [[ -d ~/.config/nvim ]]; then
  echo "No neovim boo"
  sudo apt install -y neovim nodejs npm
  mkdir -p ~/.config/nvim
fi

# Create symlinks from dotfiles to home dir
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig
ln -fs ~/dotfiles/.zshrc ~/.zshrc
# hacky way of using nvim bc symlinks don't automatically update
echo "source ~/dotfiles/nvim/init.vim" > ~/.config/nvim/init.vim
# getting zsh aliases for nvim
echo "source ~/dotfiles/.zsh_aliases" > ~/.zshenv

