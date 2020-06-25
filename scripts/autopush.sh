#!/usr/bin/env bash
#===================================================================
# AUTOPUSH.SH
#===================================================================
# SYNOPSIS
#   $ ./autopush.sh [commit message]
#
# DESCRIPTION
#   Commits and pushes all changes made in your local git repository.
#   Provided arguments will be used as the commit message.
#
# Author: Charles Ancheta

GIT_ROOT_DIR=$(git rev-parse --show-toplevel)
if [ -z "$GIT_ROOT_DIR" ]; then
  exit 1;
fi

# get commit message from first argument
ARGS="${@}"
if [ -z "$ARGS" ]; then
  MESSAGE="Autopushed"
else
  MESSAGE="$ARGS"
fi
echo "Pushing to github with message: $MESSAGE"
# move to git top level before staging changes
cd $GIT_ROOT_DIR
git add . &> /dev/null && git commit -m "$MESSAGE"
git push
