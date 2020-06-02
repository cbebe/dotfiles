# Path to your oh-my-zsh installation.
export ZSH="/home/charlie/.oh-my-zsh"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# Pure Prompt
if ! [ -d $HOME/.zsh/pure ]; then
  echo "No pure prompt? What peasantry is this??"
  mkdir -p "$HOME/.zsh"
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure

source ~/dotfiles/.aliases
# uncomment to use windows clipboard - needs x server on windows
export DISPLAY=localhost:0.0

# soy devvv
if ! [ -d $HOME/.config/neofetch ]; then
  echo "soy devvv"
  sudo apt install -y neofetch
fi
neofetch
