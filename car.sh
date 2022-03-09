#!/bin/bash

JC=javac.exe
JDK=java.exe
MAIN=Main
CMD=help

if [ ! $# -eq 0 ]; then
    CMD=$1
fi

case $CMD in
    help)
        echo "Build and run simple JAVA project"
        echo "Commands:"
        echo "  -> run ?MainClass? - builds and runs project in current directory"
        echo "  -> init - initialize project in current directory"
        echo "  -> help - outputs this text"
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

        $JC -d "target/" $(find src/ -name "*.java")

        $JDK -cp "$(find target/ -name "$MAIN.class" | xargs dirname)" $MAIN
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
    *)
        echo "Invalid command $1"
        exit 2
        ;;
esac
