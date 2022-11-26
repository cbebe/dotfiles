#!/bin/sh

# recommended directory to store your java jar files
jar_dir=/usr/local/share/java

# env file for your shell
env_file=.zshenv

# plantuml jar file
jar_file=plantuml.jar

# create JAR_DIR variable if not set
[ -z $JAR_DIR ] && $JAR_DIR=$jar_dir && echo "export \$JAR_DIR=$JAR_DIR" >>$env_file || echo "\$JAR_DIR variable already set"

mkdir -p $JAR_DIR && cd $JAR_DIR

# download plantuml jar
[ ! -f ${JAR_DIR}/${jar_file} ] && curl https://managedway.dl.sourceforge.net/project/plantuml/plantuml.jar -o $jar_file || echo "$jar_file already present"

cd - >/dev/null
