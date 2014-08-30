#!/bin/sh
cd `dirname $0`
docker stop redis
docker rm redis
./launch.sh
