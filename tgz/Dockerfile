FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN mkdir -p /build /libexec
RUN apt-get -qq -y update
RUN apt-get -qq -y install \
    bison flex curl \
    automake autoconf libtool git libreadline6-dev \
    zlib1g-dev libncurses5-dev libssl-dev libpam0g-dev \
    rake autotools-dev cgroup-lite build-essential \
    xz-utils

ENV USER root

VOLUME /out

WORKDIR /build

ADD build.sh /libexec/build.sh
RUN chmod a+x /libexec/build.sh

ENTRYPOINT ["/libexec/build.sh"]
