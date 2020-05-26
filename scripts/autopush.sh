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
while [ -z "$(find . -name .git -type d -print)" ]; do
    cd ..
done
# now push
git add .
git commit -m "$MESSAGE"
git push
