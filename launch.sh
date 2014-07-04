#!/bin/sh
docker run -d -p 6379:6379 -p 2201:2201 --name redis ruimo/dockerfile-ubuntu1404-redis
