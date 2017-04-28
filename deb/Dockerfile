FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /build /libexec
RUN apt-get -qq -y update
RUN apt-get -qq -y install \
    debhelper devscripts bison flex \
    automake autoconf libtool git libreadline6-dev \
    zlib1g-dev libncurses5-dev libssl-dev libpam0g-dev \
    rake autotools-dev cgroup-lite build-essential \
    dh-make xz-utils

ENV USER root

VOLUME /out

WORKDIR /build

ADD builddeb.sh /libexec/builddeb.sh
RUN chmod a+x /libexec/builddeb.sh

ENTRYPOINT ["/libexec/builddeb.sh"]
