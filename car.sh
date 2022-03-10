#!/bin/bash

JC=javac.exe
JDK=java.exe
MAIN=Main
CMD=help
JAR_PATH="$(echo dependencies/*.jar | sed 's/ /;/g')"

if [ ! $# -eq 0 ]; then
    CMD=$1
fi

case $CMD in
    help)
        echo "Build and run simple JAVA project"
        echo "Commands:"
        echo "  -> init - initialize project in current directory"
        echo "  -> run ?MainClass? - builds and runs project in current directory"
        echo "  -> test ?TestClass[es]? - builds and tests project in current directory (requires junit-4.x in the dependencies folder)"
        echo "  -> help - outputs this text"
        ;;

    init)
        echo "[project]" >car.conf
        echo "name: '$(pwd | xargs basename)'" >>car.conf
        echo -e "version: '0.1.0'\n" >>car.conf
        echo "[java versions]" >>car.conf
        echo "$($JDK --version)" >>car.conf
        echo "$($JC --version)" >>car.conf

        if [ ! -d "./src" ]; then 
            mkdir src
        fi
        ;;

    run)
        if [ $# -gt 1 ]; then
            MAIN="$2"
        fi

        if [ ! $(find . -maxdepth 1 -name "car.conf") ]; then
            echo "Could not find car.conf"
            exit 1
        fi

        rm -rf target/
        mkdir target

        source_files=$(find src/ -name "*.java")

        $JC -cp "$JAR_PATH;src/" -d "target/" $source_files

        $JDK -cp "$JAR_PATH;$(find target/ -name "$MAIN.class" | xargs dirname)" $MAIN
        ;;

    test)
        if [ $# -lt 1 ]; then
            echo "You need to specify the test files"
        fi

        if [ ! $(find . -maxdepth 1 -name "car.conf") ]; then
            echo "Could not find car.conf"
            exit 1
        fi

        rm -rf target/
        mkdir target

        source_files=$(find src/ -name "*.java")

        $JC -cp "$JAR_PATH;src/" -d "target/" $source_files

        test_files=$(echo $@ | sed -E 's/^[^ ]* ?//g')

        $JDK -cp "$JAR_PATH;target/" org.junit.runner.JUnitCore $test_files
        ;;

    *)
        echo "Invalid command $1"
        exit 2
        ;;
esac