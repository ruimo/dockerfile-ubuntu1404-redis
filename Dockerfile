FROM ubuntu:14.04
MAINTAINER Shisei Hanai<ruimo.uno@gmail.com>

# Install Redis.
RUN \
  apt-get update && \
  apt-get install -y wget build-essential
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
         -e 's/^# syslog-enabled no$/syslog-enabled yes/' \
         /etc/redis/redis.conf 

# Define mountable directories.
VOLUME ["/var/redis/data"]

# Define working directory.
WORKDIR /var/redis/data

# Define default command.
CMD ["redis-server", "/etc/redis/redis.conf"]

# Expose ports.
EXPOSE 6379