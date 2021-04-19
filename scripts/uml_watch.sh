[ "$1" = "" ] && echo "Usage: $(basename $0) FILE" && exit 1

nodemon --watch $1 --exec "uml $1"
