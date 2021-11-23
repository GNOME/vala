#!/bin/sh

API=`grep -e "^vala_api_version = '\([0-9]\.[0-9]*\)'$" meson.build | sed -r "s/vala_api_version = '([^ ]+)'/\1/"`
CUR_DIR=`pwd`

rm -rf subprojects/vala-bootstrap/_build _bootstrap _build

echo ">>> Building vala-bootstrap <<<"
meson subprojects download || exit 1
cd subprojects/vala-bootstrap
meson _build -Ddefault_library=static || exit 1
meson compile -C _build || exit 1

echo ">>> Building vala (stage 1) <<<"
cd "$CUR_DIR"
VALAC="$CUR_DIR/subprojects/vala-bootstrap/_build/compiler/valac --vapidir=$CUR_DIR/vapi" \
	meson _bootstrap -Dvaladoc=false -Ddefault_library=static || exit 1
meson compile -C _bootstrap || exit 1
meson test -C _bootstrap || exit 1

echo ">>> Building vala (stage 2) <<<"
cd "$CUR_DIR"
VALAC="$CUR_DIR/_bootstrap/compiler/valac-$API --vapidir=$CUR_DIR/vapi" \
	meson _build -Dprefix=/usr || exit 1
meson compile -C _build || exit 1
meson test -C _build || exit 1
