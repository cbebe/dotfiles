#!/usr/bin/env bash

# get commit message from first argument
ARGS="${@}"
if [ -z "$ARGS" ]; then
    MESSAGE="Autopushed"
else
    MESSAGE="$ARGS"
fi
echo "Pushing to github with message: $MESSAGE"
# look for .git directory before staging changes
DOTGITDIR=$(find . -name .git -type d -print)
while [ -z "$DOTGITDIR" ]; do
    cd ..
    DOTGITDIR=$(find . -name .git -type d -print)
done
# now push
git add .
git commit -m "$MESSAGE"
git push
