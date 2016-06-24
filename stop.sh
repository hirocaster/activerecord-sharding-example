#!/bin/sh

docker stop $(docker ps -a | awk '/sharding/ { print $1 }')
docker rm $(docker ps -a -q)
