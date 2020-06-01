#!/usr/bin/env bash
echo "changing permissions at: $(pwd)"

find $(pwd) -type d -exec chmod 755 {} \;
find $(pwd) -type f -exec chmod 644 {} \;


