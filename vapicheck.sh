#!/bin/bash

FILE=$1

if [ ! -f "$FILE" ]; then
	echo "'$FILE' does not exist."
	exit 1
fi

VAPI=`basename -s .vapi $1`
VAPIDIR=`dirname $1`

vapigen/vapicheck --disable-warnings --disable-since-check \
	--dump-tree tree.vala \
	--vapidir $VAPIDIR \
	$FILE || exit 1

compiler/valac --disable-warnings --disable-since-check \
	-X -Wno-discarded-qualifiers \
	-X -Wno-deprecated-declarations \
	-X -Wno-unused-value \
	-X -Werror=enum-conversion \
	-X -Werror=int-conversion \
	-X -Werror=implicit-function-declaration \
	--vapidir $VAPIDIR --pkg $VAPI \
	tree.vala || \
compiler/valac --disable-warnings --disable-since-check \
	-C \
	--vapidir $VAPIDIR --pkg $VAPI \
	tree.vala && exit 1

./tree || exit 1

rm -f tree.vala tree.c tree
