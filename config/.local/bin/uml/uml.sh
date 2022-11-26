[ "$1" = "" ] && echo "Usage: $(basename $0) FILE" && exit 1

java -jar $JAR_DIR/plantuml.jar $1
