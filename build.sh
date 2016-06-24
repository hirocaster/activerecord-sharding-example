#!/bin/bash

set -e

usage_exit() {
        echo "Usage: $0 [-n]" 1>&2
        exit 1
}

while getopts nh OPT
do
    case $OPT in
        n)  NO_CACHE="--no-cache=true"
            ;;
        h)  usage_exit
            ;;
        \?)
            ;;
    esac
done

shift $((OPTIND - 1))

CONTAINER_DIR=$(cd $(dirname $0) && pwd)/containers

docker build -t sharding/mysql ${CONTAINER_DIR}/mysql
docker build ${NO_CACHE} -t sharding/app ./
