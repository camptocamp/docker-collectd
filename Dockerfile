FROM debian:jessie

ENV COLLECTD_VERSION 5.5.0-3~bpo8+1

RUN echo 'APT::Install-Recommends "0";' > /etc/apt/apt.conf.d/50no-install-recommends
RUN echo 'APT::Install-Suggests "0";' > /etc/apt/apt.conf.d/50no-install-suggests
RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list
RUN apt-get update
RUN apt-get install -y collectd-core=$COLLECTD_VERSION
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY collectd.conf /etc/collectd/collectd.conf

ENTRYPOINT ["collectd", "-f"]
