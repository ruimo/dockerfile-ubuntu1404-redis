#!/bin/bash

kill $(ps auxw | grep redis-server | grep 6379 | awk '{print $2}')
