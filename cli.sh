#!/bin/sh
docker run --link redis:redis -i -t ruimo/myredis /bin/bash
