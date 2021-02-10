#!/bin/sh
# starts a php development server in the given port $1
[ $# -eq 0 ] && echo 'Usage: php-srv PORT' && exit 1
php -S localhost:$1 -t .
