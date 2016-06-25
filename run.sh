#!/bin/sh

set -e

CONTAINER_DIR=$(cd $(dirname $0) && pwd)/containers

docker run -d --name sharding-mysql-seq -v ${CONTAINER_DIR}/mysql/conf.d:/etc/mysql/conf.d sharding/mysql
docker run -d --name sharding-mysql-0 -v ${CONTAINER_DIR}/mysql/conf.d:/etc/mysql/conf.d sharding/mysql
docker run -d --name sharding-mysql-1 -v ${CONTAINER_DIR}/mysql/conf.d:/etc/mysql/conf.d sharding/mysql

sleep 10

RUN_OPTION="--link sharding-mysql-seq:mysql-seq --link sharding-mysql-0:mysql-0 --link sharding-mysql-1:mysql-1"

docker run -d --name sharding-app -p 3000:3000 ${RUN_OPTION} -v `pwd`:/usr/src/app sharding/app
# docker run -it --name sharding-app -p 3000:3000 ${RUN_OPTION} -v `pwd`:/usr/src/app sharding/app /bin/bash

cat <<EOF
  access to app container (http://localhost:3000)
EOF
