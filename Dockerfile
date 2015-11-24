FROM debian:jessie

RUN apt-get update
RUN apt-get install --no-install-recommends --no-install-suggests -y curl
RUN curl -s http://pkg.camptocamp.net/packages-c2c-key.gpg | apt-key add -
RUN echo "deb http://pkg.camptocamp.net/apt jessie/dev sysadmin" > /etc/apt/sources.list.d/c2c.list
RUN /bin/echo -e "Package: collectd collectd-core collectd-utils libcollectdclient1 collectd-dev libcollectdclient-dev collectd-dbg\nPin: release o=Camptocamp\nPin-Priority: 1100" > /etc/apt/preferences.d/50collectd
RUN apt-get update
RUN apt-get --no-install-recommends --no-install-suggests -y install collectd collectd-utils libyajl2 libgcrypt20 libcurl3-gnutls libpq5 libprotobuf-c1 openjdk-7-jre-headless
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

ADD collectd.conf /etc/collectd/collectd.conf
