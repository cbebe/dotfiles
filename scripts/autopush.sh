#!/usr/bin/env bash
if [ -z "$1" ]; then
    MESSAGE="Autopushed"
else
    MESSAGE="$1"
fi
DOTGITDIR=$(find . -name .git -type d -print)
while [ -z "$DOTGITDIR" ]; do
    cd ..
    DOTGITDIR=$(find . -name .git -type d -print)
done
git add .
git commit -m "$MESSAGE"
git push
