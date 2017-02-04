FROM ubuntu:14.04

MAINTAINER Kristof Coomans "kristof@2dotstwice.be"
ENV REFRESHED_AT "2017-02-04 11:13:00"

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update && DEBIAN_FRONTEND=noninteractive apt-get -qq -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y --fix-missing -q install supervisor nginx

ENV CONFIG_REFRESHED_AT "2017-02-04 11:13:00"

ADD ./files/etc/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
ADD ./files/etc/supervisor/conf.d/nginx.conf /etc/supervisor/conf.d/nginx.conf

# set nginx custom log format including the host header
ADD ./files/etc/nginx/nginx.conf /etc/nginx/nginx.conf

# logrotation configuration for nginx including a date filename extension
ADD ./files/etc/logrotate.d/nginx /etc/logrotate.d/nginx

# nginx web interface
EXPOSE 80

CMD supervisord -n -c /etc/supervisor/supervisord.conf
