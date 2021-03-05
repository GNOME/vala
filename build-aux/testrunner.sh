#!/usr/bin/env bash
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

set -e

export G_DEBUG=fatal-warnings

EXTRA_ENVIRONMENT_FILE=tests-extra-environment.sh

testfile=$1
testdirname="$(dirname $testfile)"
testfile=${testfile#$srcdir/}
testpath=${testfile/.*/}
testpath=${testpath//\//_}
testpath=${testpath//-/_}
if test -f $testdirname/$EXTRA_ENVIRONMENT_FILE; then
	source $testdirname/$EXTRA_ENVIRONMENT_FILE
fi

vapidir=$abs_top_srcdir/vapi
run_prefix=""

VALAC=$abs_top_builddir/compiler/valac$EXEEXT
VALAFLAGS="$VALAFLAGS \
	--vapidir $vapidir \
	--enable-checking \
	--disable-warnings \
	--save-temps \
	--cc $CC \
	-X -g \
	-X -O0 \
	-X -pipe \
	-X -lm \
	-X -DGETTEXT_PACKAGE=\"valac\""
VAPIGEN=$abs_top_builddir/vapigen/vapigen$EXEEXT
VAPIGENFLAGS="--vapidir $vapidir"

# Incorporate the TEST_CFLAGS.
for cflag in ${TEST_CFLAGS}; do
    VALAFLAGS="${VALAFLAGS} -X ${cflag}"
done

# Incorporate the user's CFLAGS. Matters if the user decided to insert
# -m32 in CFLAGS, for example.
for cflag in ${CFLAGS} ${CPPFLAGS} ${LDFLAGS}; do
	if [[ ! $cflag =~ ^\-O[0-9]$ ]]; then
		VALAFLAGS="${VALAFLAGS} -X ${cflag}"
	fi
done

function testheader() {
	if [ "$1" = "Packages:" ]; then
		shift
		PACKAGES="$PACKAGES $@"
	elif [ "$*" = "Invalid Code" ]; then
		INVALIDCODE=1
		INHEADER=0
		SOURCEFILE=${testpath}_invalid.vala
	elif [ "$1" = "D-Bus" ]; then
		DBUSTEST=1
		run_prefix="dbus-run-session -- $run_prefix"
	elif [ "$1" = "GIR" ]; then
		GIRTEST=1
	fi
}

function sourceheader() {
	if [ "$1" = "Program:" ]; then
		if [ "$2" = "server" ]; then
			ISSERVER=1
		fi
		ns=$testpath/$2
		ns=${ns//\//_}
		ns=${ns//-/_}
		SOURCEFILE=$ns.vala
		SOURCEFILES="$SOURCEFILES $SOURCEFILE"
	elif [ $GIRTEST -eq 1 ]; then
		if [ "$1" = "Input:" ]; then
			ns=$testpath
			SOURCEFILE=$ns.gir
			cat <<EOF > $SOURCEFILE
<?xml version="1.0"?>
<repository version="1.2"
			xmlns="http://www.gtk.org/introspection/core/1.0"
			xmlns:c="http://www.gtk.org/introspection/c/1.0"
			xmlns:glib="http://www.gtk.org/introspection/glib/1.0">
  <include name="GLib" version="2.0"/>
  <include name="GObject" version="2.0"/>
  <include name="Gio" version="2.0"/>
  <c:include name="test.h"/>
  <namespace name="Test"
			 version="1.2"
			 c:identifier-prefixes="Test"
			 c:symbol-prefixes="test">
EOF
		elif [ "$1" = "Output:" ]; then
			SOURCEFILE=$testpath.vapi.ref
		fi
	fi
}

function sourceend() {
	if [ $INVALIDCODE -eq 1 ]; then
		PACKAGEFLAGS=$([ -z "$PACKAGES" ] || echo $PACKAGES | xargs -n 1 echo -n " --pkg")
		echo '' > prepare
		echo "$VALAC $VALAFLAGS $PACKAGEFLAGS -C $SOURCEFILE" > check
		echo "RET=\$?" >> check
		echo "if [ \$RET -ne 1 ]; then exit 1; fi" >> check
		echo "exit 0" >> check
	elif [ $GIRTEST -eq 1 ]; then
		if [ $PART -eq 1 ]; then
			echo "  </namespace>" >> $SOURCEFILE
			echo "</repository>" >> $SOURCEFILE
		fi
		PACKAGEFLAGS=$([ -z "$PACKAGES" ] || echo $PACKAGES | xargs -n 1 echo -n " --pkg")
		echo "$VAPIGEN $VAPIGENFLAGS $PACKAGEFLAGS --library $ns $ns.gir && tail -n +5 $ns.vapi|sed '\$d'|diff -wu $ns.vapi.ref -" > check
	else
		PACKAGEFLAGS=$([ -z "$PACKAGES" ] || echo $PACKAGES | xargs -n 1 echo -n " --pkg")
		echo "$VALAC $VALAFLAGS $PACKAGEFLAGS -o $ns$EXEEXT $SOURCEFILE" >> prepare
		if [ $DBUSTEST -eq 1 ]; then
			if [ $ISSERVER -eq 1 ]; then
				echo "./$ns$EXEEXT" >> check
			fi
		else
			echo "./$ns$EXEEXT" >> check
		fi
	fi
}

PACKAGES=${PACKAGES:-gio-2.0}

unset SOURCEFILE

testdir=_test.$$
rm -rf ./$testdir
mkdir $testdir
cd $testdir

case "$testfile" in
*.gs)
	SOURCEFILE=$testpath.gs
	;&
*.vala)
	SOURCEFILE=${SOURCEFILE:-$testpath.vala}
	cat "$abs_srcdir/$testfile" > ./$SOURCEFILE
	PACKAGEFLAGS=$([ -z "$PACKAGES" ] || echo $PACKAGES | xargs -n 1 echo -n " --pkg")
	$VALAC $VALAFLAGS $PACKAGEFLAGS -o $testpath$EXEEXT $SOURCEFILE
	./$testpath$EXEEXT
	;;
*.test)
	rm -f prepare check
	echo 'set -e' >> prepare
	run_prefix=""
	PART=0
	INHEADER=1
	INVALIDCODE=0
	GIRTEST=0
	DBUSTEST=0
	ISSERVER=0
	while IFS="" read -r line; do
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
					sourceheader $line
				else
					echo "$line" >> $SOURCEFILE
				fi
			fi
		fi
	done < "$abs_srcdir/$testfile"
	sourceend
	cat prepare check > $ns.check
	$run_prefix bash $ns.check
	;;
esac

cd ..
rm -rf ./$testdir
