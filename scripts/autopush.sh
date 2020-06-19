#!/usr/bin/env bash

# get commit message from first argument
ARGS="${@}"
if [ -z "$ARGS" ]; then
    MESSAGE="Autopushed"
else
    MESSAGE="$ARGS"
fi
echo "Pushing to github with message: $MESSAGE"
# move to git top level before staging changes
cd $(git rev-parse --show-toplevel)
# now push
git add . &> /dev/null && git commit -m "$MESSAGE"
git push

