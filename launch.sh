#!/bin/sh
docker run -d -p 6379:6379 -v /var/redis:/var/redis --name redis ruimo/dockerfile-ubuntu1404-redis
