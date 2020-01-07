#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd $DIR

make && make install

# Install workaround: libtool does not copy this DLL at the right place under MinGW-64
# (search "place dlname in correct position for cygwin" in ltmain.sh)
cp -f local/lib/bin/*.dll local/bin/

popd
