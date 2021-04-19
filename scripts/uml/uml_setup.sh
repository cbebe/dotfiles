#!/bin/sh

cd $(dirname $0)

get_path() {
  echo "$(cd "$(dirname "$1")" && pwd -P)/$(basename "$1")"
}

# get a directory that is in path
user_bin_dir=$HOME/.local/bin
# big assumption that you have systemd
[ ! -z $(echo $PATH | grep "$HOME/.local/bin") ] && user_bin_dir=$(systemd-path user-binaries)

uml_exec=$user_bin_dir/uml
uml_watch=$user_bin_dir/umlw

# link uml.sh to uml
[ ! -f $uml_exec ] && ln -s $(get_path uml.sh) $uml_exec
# if nodemon is present, install watcher as well
if [ ! -f $uml_watch ]; then
  if [ ! -z $(which nodemon) ]; then
    ln -s $(get_path uml_watch.sh) $uml_watch
  else
    echo "nodemon not found"
  fi
else
  echo "$uml_watch exists"
fi


cd - >/dev/null
