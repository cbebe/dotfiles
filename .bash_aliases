#!/usr/bin/env bash
# -------
# Aliases
# -------


# enables alias expansion
shopt -s expand_aliases

alias vi="vim"
alias q="exit"
alias es="vi ~/dotfiles/.bash_aliases"

alias ec="echo $?" # check for errors

# auto push on github
alias gp="~/dotfiles/scripts/autopush.sh"
# real home is too messy when viewed on wsl ewww
alias chome="cd /mnt/c/Users/maple/home"
# change permissions in case it gets messed up
alias cperm="~/dotfiles/scripts/changeperm.sh"

