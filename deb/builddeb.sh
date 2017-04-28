#!/bin/bash
set -xe

export DEBIAN_FRONTEND=noninteractive

VERSION=${1:-0.8.5}
MAINTAINER=${2:-'udzura@udzura.jp'}

if test -d /build/haconiwa
then
    mkdir /build/haconiwa-$VERSION
    rsync -a /build/haconiwa/ /build/haconiwa-$VERSION/
    cd /build/haconiwa-$VERSION
        rake clean
    cd -
else
    git clone https://github.com/haconiwa/haconiwa.git /build/haconiwa-$VERSION
    cd /build/haconiwa-$VERSION
        git checkout $(git rev-parse v$VERSION)
    cd -
fi

if test -f /build/build_config.rb
then
    cp -f /build/build_config.rb /build/haconiwa-$VERSION/build_config.rb
fi

cd /build/haconiwa-$VERSION
    rake mruby
    dh_make -s -e $MAINTAINER --createorig -y
    cp -v packages/deb/debian/* debian/
    rm -rf debian/*.ex debian/*.EX
    debuild -uc -us
cd ../
cp -v *.deb /out/pkg
