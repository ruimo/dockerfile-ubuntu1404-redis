#!/bin/sh
cd `dirname $0`

COUNT=0
while true; do
  ./ping.sh
  rc=$?
  if [ $rc = "0" ]; then
    exit 0
  fi
  if [ $COUNT -eq 5 ]; then
    ./restart.sh
    exit $rc
  fi
  COUNT=`expr $COUNT + 1`
  sleep 1
done

