#!/bin/sh

# https://www.reddit.com/r/NixOS/comments/ae9q01/how_to_os_from_inside_a_nix_file/

echo "{ hostname = \"$(hostname)\"; operatingSystem = \"$(uname)\"; }" > ~/.config/nixpkgs/machine.nix