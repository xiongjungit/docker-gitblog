#
# MAINTAINER        dockerxman,xiongjun <fenyunxx@163.com>
# DOCKER-VERSION    1.7.1
#
# Dockerizing ubuntu14.04: Dockerfile for building ubuntu images
#
FROM       daocloud.io/library/ubuntu:latest
MAINTAINER dockerxman,xiongjun <fenyunxx@163.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm

ADD sources.list /etc/apt/sources.list
RUN \
  apt-get update && \
  apt-get install -y unzip && \
  apt-get install -y vim && \
  apt-get install -y wget && \
  apt-get install -y curl && \
  apt-get install -y supervisor && \
  apt-get install -y nginx && \
  apt-get install -y openssl && \
  apt-get install -y libmcrypt-dev && \
  apt-get install -y mcrypt && \
  apt-get install -y php5-fpm && \
  apt-get install -y php5-cli && \
  apt-get install -y php5-curl && \
  apt-get install -y php5-mcrypt && \
  apt-get install -y php5-gd && \
  apt-get install -y php5-mysql && \
  apt-get install -y php5-json && \
  apt-get install -y php5-readline && \
  apt-get install -y php5-xcache && \
  apt-get install -y php-pear && \
  apt-get clean && \
  apt-get autoclean

RUN rm -rf /usr/share/nginx/html 

RUN mkdir /www

RUN wget --no-check-certificate -O /tmp/gitblog.zip https://github.com/jockchou/gitblog/archive/master.zip
RUN unzip /tmp/gitblog.zip -d /www
RUN rm /tmp/gitblog.zip

ADD nginx_nginx.conf /etc/nginx/nginx.conf
ADD nginx_default.conf /etc/nginx/sites-available/default

RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php5/cli/php.ini
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php5/fpm/php.ini

ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD supervisor_nginx.conf /etc/supervisor/conf.d/supervisor_nginx.conf
ADD supervisor_php5-fpm.conf /etc/supervisor/conf.d/supervisor_php-fpm.conf
ADD php_www.conf /etc/php5/fpm/pool.d/www.conf

COPY gitblog-master/ /www/gitblog-master
RUN chown -R www-data:www-data /www/gitblog-master

VOLUME ["/www/gitblog-master/"]

EXPOSE 80

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisor/supervisord.conf"]
