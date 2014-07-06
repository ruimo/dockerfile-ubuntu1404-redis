dockerfile-ubuntu1404-redis
===========================

# Docker file for ubuntu 14.04 + redis

Redis server is monitored by monit and will be automatically restarted once it is aborted.

# How to use:

Just use launch.sh(Mac/Linux) or launch.bat(Windows) to start server. The container's name is 'redis'.
Once Redis server is launched, you can check the server by cli.sh/cli.bat.

```
$ ./cli.sh
root@xxxxxxxxx:/var/redis/data# redis-cli -h redis
redis:6379> set Hello "World"
OK
redis:6379> get Hello
"World"
```

You can link to redis server by specifying link option such as 'docker run --link redis:redis'. Your can access Redis server through host name 'redis'.
