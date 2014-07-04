FROM ubuntu:14.04
MAINTAINER Shisei Hanai<ruimo.uno@gmail.com>

# log will be written in /var/log/redis/redis.log
# data will be written in /var/redis/data/

RUN \
  apt-get update && \
  apt-get install -y wget build-essential monit

# Install Redis.
RUN \
  cd /tmp && \
  wget http://download.redis.io/redis-stable.tar.gz && \
  tar xf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable*

RUN \
  sed -i -e 's/^\(dir .*\)$/# \1\ndir \/var\/redis\/data\//' \
         -e 's/^\(logfile .*\)$/# \1/' \
         -e 's/^#?\s*daemonize .*/daemonize yes/' \
         -e 's;^# syslog-enabled.*$;syslog-enabled yes;' \
         -e 's/^\(# bind .*\)$/# \1\nbind 0.0.0.0/' \
         /etc/redis/redis.conf 

ADD monit   /etc/monit/conf.d/

# Define mountable directories.
VOLUME ["/var/redis/data"]

# Define working directory.
WORKDIR /var/redis/data

EXPOSE 6379

CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]
