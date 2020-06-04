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
# install tmux
if ! [[ -e ~/.tmux.conf ]]; then
  echo "No tmux boo"
  sudo apt install -y tmux
fi

# install deno
if ! [[ -d ~/.deno ]]; then
  echo "No Deno boo"
  sudo apt install -y unzip
  curl -fsSL https://deno.land/x/install/install.sh | sh
fi

# Create symlinks from dotfiles to home dir
ln -fs ~/dotfiles/.gitconfig ~/.gitconfig
ln -fs ~/dotfiles/.zshrc ~/.zshrc
ln -fs ~/dotfiles/.tmux.conf ~/.tmux.conf
# hacky way of using nvim bc symlinks don't automatically update
echo "source ~/dotfiles/nvim/init.vim" > ~/.config/nvim/init.vim
# getting zsh aliases for nvim
echo "source ~/dotfiles/.zsh_aliases" > ~/.zshenv

