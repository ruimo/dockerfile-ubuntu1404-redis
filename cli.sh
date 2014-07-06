#!/bin/sh
docker run --link redis:redis -i -t ruimo/dockerfile-ubuntu1404-redis /bin/bash
