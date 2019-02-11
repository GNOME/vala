#!/bin/sh

API=`grep -e "^vala_api_version = '\([0-9]\.[0-9]*\)'$" meson.build | sed -r "s/vala_api_version = '([^ ]+)'/\1/"`

PWD=$(pwd)
rm -rf _bootstrap _bootstrap_install _build

meson _bootstrap -Dvaladoc=false -Dprefix=$PWD/_bootstrap_install || exit 1
ninja -C _bootstrap || exit 1

LD_LIBRARY_PATH="$PWD/_bootstrap/vala:$PWD/_bootstrap/codegen" VALAC="$PWD/_bootstrap/compiler/valac-$API --vapidir $PWD/vapi" meson _build -Dprefix=/usr || exit 1
LD_LIBRARY_PATH="$PWD/_bootstrap/vala:$PWD/_bootstrap/codegen" ninja -C _build || exit 1
LD_LIBRARY_PATH="$PWD/_bootstrap/vala:$PWD/_bootstrap/codegen" ninja -C _build test || exit 1
