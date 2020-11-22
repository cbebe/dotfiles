export TERMINAL=gnome-terminal

set -o vi

export JAVA_HOME=$HOME/jdk
export SHELL=/bin/bash
export PATH=$JAVA_HOME/bin:\
$HOME/maven/bin:\
$HOME/spotbugs-4.1.3/bin:\
$HOME/.local/bin:\
$HOME/.matlab/MATLAB/R2020b/bin:\
$HOME/gems/bin:$PATH

export GEM_HOME=$HOME/gems




source ~/dotfiles/bash_aliases
