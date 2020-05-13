bind "set bell-style none"
# -------
# Aliases
# -------

alias ls="ls -al"
alias py="winpty py"
alias q="exit"
alias c="code ./"
alias s="source ~/dotfiles/.bashrc"
alias es="vi ~/dotfiles/.bashrc"
alias vrc="vi ~/dotfiles/.vimrc"

alias phil="cd ~/WD/codingwbb/phil265/markdown"
# open current directory in explorer
alias exp="explorer ."

# because i keep forgetting how to do this
alias gen-ssh="ssh-keygen -t rsa -b 4096 -C \"cancheta@ualberta.ca\""
alias gen-add="eval $(ssh-agent -s) && ssh-add ~/.ssh/id_rsa"
alias gen-test="ssh -T git@github.com"

