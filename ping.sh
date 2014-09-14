#!/bin/sh
docker run --link redis:redis ruimo/dockerfile-ubuntu1404-redis redis-cli -h redis PING
