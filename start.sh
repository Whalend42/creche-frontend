#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
DOCKER_FILE="${SCRIPT_DIR}Dockerfile"
OPT_REGEX='^(b)?(r)?(s)?(e)?$'

opt=$1

do_build=0
do_run=0
do_start=0
do_exec=0

if [[ $opt =~ $OPT_REGEX ]]; then
    if [[ "${BASH_REMATCH[1]}" != "" ]]; then
        printf "Will build"
        do_build=1
    fi
    if [[ "${BASH_REMATCH[2]}" != "" ]]; then
        printf "Will run"
        do_run=1
    fi
    if [[ "${BASH_REMATCH[3]}" != "" ]]; then
        printf "Will start"
        do_start=1
    fi
    if [[ "${BASH_REMATCH[4]}" != "" ]]; then
        printf "Will exec"
        do_exec=1
    fi
else
    printf "no valid parameter given. Received: '$opt', expected ${OPT_REGEX}"
    exit 1
fi

if [[ -f $DOCKER_FILE ]]; then
    printf "Docker file do not exist where expected: ${DOCKER_FILE}"
fi

printf "let's start"

if [ $do_build -eq 1 ]; then
    printf "\n**** BUILDING ****\n"
    docker build -t creche-frontend $SCRIPT_DIR
fi

if [ $do_run -eq 1 ]; then
    printf "\n**** RUNNING ****\n"
    docker run \
        --mount type=bind,src=$SCRIPT_DIR/app,dst=/app \
        --name creche-frontend \
        -dp 3000:3000 creche-frontend
fi

if [ $do_start -eq 1 ]; then
    printf "\n**** STARTING ****\n"
    docker container start creche-frontend
fi

# seems to have an error when quitting the container
if [ $do_exec -eq 1 ]; then
    printf "\n**** EXECUTING ****\n"
    docker exec -it creche-frontend /bin/sh
fi

printf "finished"
