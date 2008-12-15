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

export G_DEBUG=fatal_warnings

VALAC=$topbuilddir/compiler/valac
CC="gcc -std=c99"
CFLAGS="-O0 -g3 -I$topsrcdir -I$topbuilddir"
LDLIBS="-lm"

CODE=0

function testheader() {
	if [ "$1" = "Packages:" ]; then
		shift
		PACKAGES="$@"
		for pkg in $PACKAGES; do
			if [ "$pkg" = "dbus-glib-1" ]; then
				echo 'eval `dbus-launch --sh-syntax`' >> prepare
				echo 'trap "kill $DBUS_SESSION_BUS_PID" INT TERM EXIT' >> prepare
			fi
		done
	fi
}

function sourceheader() {
	if [ "$1" = "Program:" ]; then
		PROGRAM=$2
		SOURCEFILE=$PROGRAM.vala
	fi
}

function sourceend() {
	if [ -n "$PROGRAM" ]; then
		echo "$VALAC $(echo $PACKAGES | xargs -n 1 -r echo --pkg) -C $SOURCEFILE" >> build
		echo "$CC $CFLAGS -o $PROGRAM$EXEEXT $PROGRAM.c \$(pkg-config --cflags --libs glib-2.0 gobject-2.0 $PACKAGES) $LDLIBS" >> build
		echo "./$PROGRAM$EXEEXT" > check
	fi
}

for testfile in "$@"; do
	testname=$(basename $testfile)
	testdir=${testname/.test/.d}
	rm -rf $testdir
	mkdir $testdir
	cd $testdir

	touch prepare build check cleanup

	echo 'set -e' >> prepare

	PART=0
	INHEADER=1
	PACKAGES=
	PROGRAM=
	cat "$builddir/$testfile" | while true; do
		if IFS="" read -r line; then
			if [ $PART -eq 0 ]; then
				if [ -n "$line" ]; then
					testheader $line
				else
					PART=1
				fi
			else
				if [ $INHEADER -eq 1 ]; then
					if [ -n "$line" ]; then
						sourceheader $line
					else
						INHEADER=0
					fi
				else
					if echo "$line" | grep -q "^[A-Za-z]\+:"; then
						sourceend
						PART=$(($PART + 1))
						INHEADER=1
						PROGRAM=
						sourceheader $line
					else
						echo "$line" >> $SOURCEFILE
					fi
				fi
			fi
		else
			sourceend
			break
		fi
	done

	cat prepare build check cleanup > script
	if ! bash script >log 2>&1; then
		cat log
		CODE=1
	fi

	cd $builddir

	if [ $CODE -eq 0 ]; then
		rm -rf $testdir
	fi
done

exit $CODE

