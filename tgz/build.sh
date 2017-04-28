#!/bin/bash
set -xe

export DEBIAN_FRONTEND=noninteractive
export LANG=C

VERSION=${1:-0.8.5}

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
    if ! grep -q 'VERSION = "'$VERSION'"' mrblib/haconiwa/version.rb; then
        sed -i.old 's/.*VERSION.*/VERSION = "'$VERSION'"/' mrblib/haconiwa/version.rb
    fi

    rake mruby
    rake release:tarball
    cp -v pkg/*.tgz /out/pkg
# cd end
