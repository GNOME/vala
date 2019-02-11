#!/bin/sh

API=`grep -e "^vala_api_version = '\([0-9]\.[0-9]*\)'$" meson.build | sed -r "s/vala_api_version = '([^ ]+)'/\1/"`

PWD=$(pwd)
rm -rf _bootstrap _bootstrap_install _build

meson _bootstrap -Dvaladoc=false -Dprefix=$PWD/_bootstrap_install
ninja -C _bootstrap

VALAC="$PWD/_bootstrap/compiler/valac-$API --vapidir $PWD/vapi" meson _build -Dprefix=/usr
ninja -C _build
ninja -C _build test
