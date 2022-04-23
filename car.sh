#!/bin/bash

MVN=$(which mvn)
JC=$(which javac.exe)
JDK=$(which java.exe)
CMD=help

if [ -z "$MVN" ]; then
    echo "ERROR: Maven is not installed."
fi

if [ ! $# -eq 0 ]; then
    CMD=$1
    shift 1
fi

case $CMD in
    help)
        echo "Build and run simple JAVA project"
        echo "Commands:"
        echo "  -> init  - initialize project in current directory
    -n <project_name> => name of the project (default is 'demo')
    -g <group_name> => id of the group (default is 'com.example')"
        echo "  -> build - cleans target and resolves dependencies"
        echo "  -> run   - builds and runs project in current directory
    -f <main_class> => marks the main class (default is 'com.example.demo.DemoApplication')
    -a <args...> => command line args"
        echo "  -> test  - builds and tests project in current directory
    -f <test_class...> "
        echo "  -> help  - outputs this text"
        ;;

    init)
        artifactId=demo
        groupId=com.example

        while [ ! -z $1 ]; do
            case $1 in
                -n)
                    shift 1
                    artifactId=$([ -z $1 ] && echo $artifactId || echo $1)
                    ;;
                -g)
                    shift 1
                    groupId=$([ -z $1 ] && echo $groupId || echo $1) 
                    ;;
                *)
                    echo "Invalid args"
                    exit 1
                    ;;
            esac
            shift 1
        done

        curl -qq https://start.spring.io/starter.zip \
            -d type=maven-project \
            -d language=java \
            -d bootVersion=2.6.7 \
            -d baseDir=$artifactId \
            -d name=$artifactId \
            -d artifactId=$artifactId \
            -d groupId=$groupId \
            -d description= \
            -d packageName=$groupId.$artifactId \
            -d packaging=jar \
            -d javaVersion=11 \
            -o "$artifactId.zip"

        unzip -q "$artifactId.zip"
        rm "$artifactId.zip"

        echo "Project $artifactId created"
        ;;

    run)
        XLINT=$(which xmllint)
        if [ -z $XLINT ]; then
            echo "Make sure that xmllint is installed"
            exit 1
        fi

        if [ ! -f pom.xml ]; then
            echo "Make sure the project 'pom.xml' is present"
            exit 1
        fi

        ARCT=$(xmllint --xpath "/*[local-name()='project']/*[local-name()='artifactId']/text()" pom.xml) 
        GRP=$(xmllint --xpath "/*[local-name()='project']/*[local-name()='groupId']/text()" pom.xml)
        MAIN=${GRP}.${ARCT}.DemoApplication

        ARGS=

        while [ ! -z $1 ]; do
            case $1 in
                -f)
                    shift 1
                    MAIN=$1
                    ;;
                -a)
                    shift 1
                    while [[ ! $1 =~ (^-|^$) ]]; do
                        ARGS+=" $1"
                        shift 1
                    done
                    ;;
                *)
                    echo "Invalid args"
                    exit 1
                    ;;
            esac
            shift 1
        done

        $MVN exec:java -Dexec.mainClass="$MAIN" -Dexec.args="$ARGS"
        ;;

    test)
        TEST=

        while [ ! -z $1 ]; do
            case $1 in
                -f)
                    shift 1
                    TEST=$1
                    ;;
                *)
                    echo "Invalid args"
                    exit 1
                    ;;
            esac
            shift 1
        done
        
        $MVN test -Dtest="$TEST"
        ;;

    build)
        $MVN clean install -U
        ;;
    *)
        echo "Invalid command $1"
        exit 2
        ;;
esac

exit 0
