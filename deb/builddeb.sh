#!/bin/bash
set -xe

export DEBIAN_FRONTEND=noninteractive
export LANG=C

VERSION=${1:-0.8.5}
MAINTAINER=${2:-'udzura@udzura.jp'}
MAINTAINER_NAME=${3:-'Uchio Kondo'}

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
        cp packages/deb/debian/changelog /tmp/.changelog
        cat <<EOLOG > packages/deb/debian/changelog
haconiwa ($VERSION-1) unstable; urgency=medium

  * Customized deb build

 -- $MAINTAINER_NAME <$MAINTAINER>  $(date "+%a, %e %b %Y %H:%M:%S %z")

EOLOG
        cat /tmp/.changelog >> packages/deb/debian/changelog
    fi

    rake mruby
    dh_make -y -s -e $MAINTAINER --createorig -y
    cp -v packages/deb/debian/* debian/
    rm -rf debian/*.ex debian/*.EX
    debuild --no-tgz-check -uc -us
cd ../
cp -v *.deb /out/pkg
