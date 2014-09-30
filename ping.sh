#!/bin/sh
docker run --rm --link redis:redis ruimo/dockerfile-ubuntu1404-redis redis-cli -h redis PING
