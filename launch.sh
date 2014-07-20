#!/bin/sh
docker run -d -p 6379:6379 -v /var/redis/data:/var/redis/data --name redis ruimo/dockerfile-ubuntu1404-redis
