#!/bin/bash
# testrunner.sh
#
# Copyright (C) 2006-2008  Jürg Billeter
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
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

builddir=$PWD
topbuilddir=$builddir/..
srcdir=`dirname $0`
topsrcdir=$srcdir/..
vapidir=$topsrcdir/vapi
exe=$EXEEXT

# make sure we detect failed test cases
set -o pipefail

export G_DEBUG=fatal_warnings

VALAC=$topbuilddir/compiler/valac
CC="gcc -std=c99"
CFLAGS="-O0 -g3 -I$topsrcdir -I$topbuilddir"
LDLIBS="-lm"

CODE=0

for testcasesource in "$@"
do
	testsrc=${testcasesource/.vala/}
	if ! $VALAC -C --vapidir "$vapidir" --basedir $topsrcdir -d $topbuilddir $testsrc.vala > $testsrc.err 2>&1
	then
		echo "ERROR: Compiling" $testcasesource 
		cat $testsrc.err
		CODE=1
		continue
	fi
	if ! $CC $CFLAGS $testsrc.c $(pkg-config --cflags --libs gobject-2.0) -o $testsrc $LDLIBS > $testsrc.err 2>&1
	then
		echo "ERROR: Compiling" $testsrc.c
		cat $testsrc.err
		CODE=1
		continue
	fi
	if ./$testsrc 2>&1 | tee $testsrc.err | cmp -s $testsrc.exp
	then
		rm $testsrc.c $testsrc.h $testsrc$exe $testsrc.err
	else
		echo "ERROR: test failed. This is the difference between" $testsrc.exp "and" $testsrc.err
		diff -u $testsrc.exp $testsrc.err
		CODE=1
	fi
done

exit $CODE
