FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/50no-install-recommends
RUN echo 'APT::Install-Suggests "0";' > /etc/apt/apt.conf.d/50no-install-suggests
RUN echo "deb http://pkg.camptocamp.net/apt xenial/dev sysadmin" > /etc/apt/sources.list.d/collectd-c2c.list
RUN apt-key adv --keyserver hkps.pool.sks-keyservers.net --recv-keys 0xE2DCB07F5C662D02
COPY /50collectd /etc/apt/preferences.d/

RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install \
    runit \
    collectd-core \
    collectd-utils \
    libcurl3-gnutls \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN touch /etc/inittab
RUN mkdir -p /etc/service/collectd/
COPY /collectd.run /etc/service/collectd/run

RUN mkdir -p /etc/collectd/collectd.conf.d
COPY /collectd.conf /etc/collectd/collectd.conf

ENTRYPOINT ["/usr/sbin/runsvdir-start"]
