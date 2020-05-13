bind "set bell-style none"
export PS1="\\w:\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\$ "
# -------
# Aliases
# -------

# reflect gitconfig changes to the dotfiles one
alias gc="cp ~/.gitconfig ~/dotfiles/.gitconfig"
alias ls="ls -al"
alias py="winpty py"
alias q="exit"
alias c="code ./"
alias s="source ~/dotfiles/.bashrc"
alias es="vi ~/dotfiles/.bashrc"
alias vrc="vi ~/dotfiles/.vimrc"

alias phil="cd ~/WD/codingwbb/phil265/markdown"
