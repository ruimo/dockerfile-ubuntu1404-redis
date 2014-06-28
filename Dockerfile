FROM ubuntu:14.04
MAINTAINER Shisei Hanai<ruimo.uno@gmail.com>

RUN \
  apt-get update && \
  apt-get install -y wget build-essential openssh-server monit

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
         -e 's/^# syslog-enabled no$/syslog-enabled yes/' \
         -e 's/^\(# bind .*\)$/# \1\nbind 0.0.0.0/' \
         /etc/redis/redis.conf 

ADD monit   /etc/monit/conf.d/

# This user is a user for ssh login. Initial password = 'password'.
RUN useradd -p `perl -e "print(crypt('password', 'AB'));"` -s /bin/bash --create-home --user-group redis

# This user is a user to execute redis.
RUN useradd -s /bin/false --user-group redisserver

# Force to change password.
RUN passwd -e redis
RUN gpasswd -a redis sudo

# Use non standard port for ssh(22) to prevent atack.
RUN sed -i.bak "s/Port 22/Port 2201/" /etc/ssh/sshd_config

RUN mkdir /home/redis/.ssh
ONBUILD ADD authorized_keys /home/redis/.ssh/authorized_keys
ONBUILD RUN chmod 755 /home/redis
ONBUILD RUN chmod 600 /home/redis/.ssh/authorized_keys
ONBUILD RUN chown -R redis:redis /home/redis/.ssh

# Define mountable directories.
VOLUME ["/var/redis/data"]

# Define working directory.
WORKDIR /var/redis/data

EXPOSE 6379
EXPOSE 2201

CMD ["/usr/bin/monit", "-I", "-c", "/etc/monit/monitrc"]
