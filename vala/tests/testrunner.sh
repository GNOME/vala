#!/bin/bash
# testrunner.sh
#
# Copyright (C) 2006  Jürg Billeter
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
#
# Author:
# 	Jürg Billeter <j@bitron.ch>

builddir=$(dirname $0)
topbuilddir=$builddir/..
vapidir=$topbuilddir/vapi

VALAC=$topbuilddir/compiler/valac
CC="gcc -std=c99"
CFLAGS="-O0 -g3"
LDLIBS="-lm"

CODE=0

for testcasesource in "$@"
do
	testcase=${testcasesource/.vala/}
	if ! $VALAC --vapidir "$vapidir" $testcase.vala > $testcase.err 2>&1 
	then
		CODE=1
		continue
	fi
	if ! $CC $CFLAGS $(pkg-config --cflags --libs gobject-2.0) $LDLIBS -o $testcase $testcase.c > $testcase.err 2>&1 
	then
		CODE=1
		continue
	fi
	if ./$testcase | tee $testcase.err | cmp -s $testcase.out 
	then
		rm $testcase.err
	else
		CODE=1
	fi
done

exit $CODE
