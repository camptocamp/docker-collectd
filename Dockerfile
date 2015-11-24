FROM debian:jessie

ENV COLLECTD_VERSION 5.5.0-3~bpo8+1

RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list
RUN apt-get update
RUN apt-get install -y collectd=$COLLECTD_VERSION
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

#ADD collectd.conf /etc/collectd/collectd.conf
