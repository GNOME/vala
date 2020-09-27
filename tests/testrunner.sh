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

builddir=$PWD
topbuilddir=$builddir/..
srcdir=$PWD/`dirname $0`
topsrcdir=$srcdir/..
vapidir=$topsrcdir/vapi
run_prefix=""

VALAC=$topbuilddir/compiler/valac$EXEEXT
VALAFLAGS="$VALAFLAGS \
	--vapidir $vapidir \
	--enable-checking \
	--disable-warnings \
	--main main \
	--save-temps \
	--cc $CC \
	-X -g \
	-X -O0 \
	-X -pipe \
	-X -lm \
	-X -DGETTEXT_PACKAGE=\\\"valac\\\" \
	-X -Werror=return-type \
	-X -Werror=init-self \
	-X -Werror=implicit \
	-X -Werror=sequence-point \
	-X -Werror=return-type \
	-X -Werror=uninitialized \
	-X -Werror=pointer-arith \
	-X -Werror=int-to-pointer-cast \
	-X -Werror=pointer-to-int-cast \
	-X -Wformat \
	-X -Werror=format-security \
	-X -Werror=format-nonliteral \
	-X -Werror=redundant-decls \
	-X -Werror=int-conversion"
VAPIGEN=$topbuilddir/vapigen/vapigen$EXEEXT
VAPIGENFLAGS="--vapidir $vapidir"

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
		testpath=${testfile/.test/}
		ns=${testpath//\//_}
		ns=${ns//-/_}\_invalid
		SOURCEFILE=$ns.vala
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
		testpath=${testfile/.test/}/$2
		ns=${testpath//\//_}
		ns=${ns//-/_}
		SOURCEFILE=$ns.vala
		SOURCEFILES="$SOURCEFILES $SOURCEFILE"
	elif [ $GIRTEST -eq 1 ]; then
		if [ "$1" = "Input:" ]; then
			testpath=${testfile/.test/}
			ns=${testpath//\//_}
			ns=${ns//-/_}
			SOURCEFILE=$ns.gir
			cat <<EOF > $SOURCEFILE
<?xml version="1.0"?>
<repository version="1.2"
			xmlns="http://www.gtk.org/introspection/core/1.0"
			xmlns:c="http://www.gtk.org/introspection/c/1.0"
			xmlns:glib="http://www.gtk.org/introspection/glib/1.0">
  <include name="GLib" version="2.0"/>
  <include name="GObject" version="2.0"/>
  <c:include name="test.h"/>
  <namespace name="Test"
			 version="1.2"
			 c:identifier-prefixes="Test"
			 c:symbol-prefixes="test">
EOF
		elif [ "$1" = "Output:" ]; then
			testpath=${testfile/.test/}
			ns=${testpath//\//_}
			ns=${ns//-/_}
			SOURCEFILE=$ns.vapi.ref
		fi
	fi
}

function sourceend() {
	if [ -n "$testpath" ]; then
		if [ $INVALIDCODE -eq 1 ]; then
			PACKAGEFLAGS=$([ -z "$PACKAGES" ] || echo $PACKAGES | xargs -n 1 echo -n " --pkg")
			echo '' > prepare
			echo "G_DEBUG=fatal-warnings $VALAC $VALAFLAGS $PACKAGEFLAGS -C $SOURCEFILE" > check
			echo "RET=\$?" >> check
			echo "if [ \$RET -ne 1 ]; then exit 1; fi" >> check
			echo "exit 0" >> check
		elif [ $GIRTEST -eq 1 ]; then
			if [ $PART -eq 1 ]; then
				echo "  </namespace>" >> $SOURCEFILE
				echo "</repository>" >> $SOURCEFILE
			fi
			echo "G_DEBUG=fatal-warnings $VAPIGEN $VAPIGENFLAGS --library $ns $ns.gir && tail -n +5 $ns.vapi|sed '\$d'|diff -wu $ns.vapi.ref -" > check
		else
			PACKAGEFLAGS=$([ -z "$PACKAGES" ] || echo $PACKAGES | xargs -n 1 echo -n " --pkg")
			echo "G_DEBUG=fatal-warnings $VALAC $VALAFLAGS $PACKAGEFLAGS -o $ns$EXEEXT $SOURCEFILE" >> prepare
			if [ $DBUSTEST -eq 1 ]; then
				if [ $ISSERVER -eq 1 ]; then
					echo "G_DEBUG=fatal-warnings ./$ns$EXEEXT" >> check
				fi
			else
				echo "G_DEBUG=fatal-warnings ./$ns$EXEEXT" >> check
			fi
		fi
	fi
}

testdir=_test
rm -rf $testdir
mkdir $testdir
cd $testdir

echo -n -e "TEST: Preparing...\033[72G"

cat << "EOF" > checkall
all=0
fail=0
EOF

PACKAGES=gio-2.0
for testfile in "$@"; do
	rm -f prepare check
	echo 'set -e' >> prepare
	run_prefix=""

	case "$testfile" in
	*.vala)
		testpath=${testfile/.vala/}
		ns=${testpath//\//_}
		ns=${ns//-/_}
		SOURCEFILE=$ns.vala

		cat "$srcdir/$testfile" >> $SOURCEFILE

		PACKAGEFLAGS=$([ -z "$PACKAGES" ] || echo $PACKAGES | xargs -n 1 echo -n " --pkg")
		echo "G_DEBUG=fatal-warnings $VALAC $VALAFLAGS $PACKAGEFLAGS -o $ns$EXEEXT $SOURCEFILE" >> prepare
		echo "G_DEBUG=fatal-warnings ./$ns$EXEEXT" >> check
		;;
	*.test)
		PART=0
		INHEADER=1
		INVALIDCODE=0
		GIRTEST=0
		DBUSTEST=0
		ISSERVER=0
		testpath=
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
						testpath=
						sourceheader $line
					else
						echo "$line" >> $SOURCEFILE
					fi
				fi
			fi
		done < "$srcdir/$testfile"
		sourceend
		;;
	esac

	cat prepare check > $ns.check
	cat << EOF >> checkall
echo -n -e "  /$testpath: \033[72G"
((all++))
if $run_prefix bash $ns.check &>log; then
	echo -e "\033[0;32mOK\033[m"
else
	((fail++))
	echo -e "\033[0;31mFAIL\033[m"
	cat log
fi
EOF
done

cat << "EOF" >> checkall
if [ $fail -eq 0 ]; then
	echo "All $all tests passed"
else
	echo "$fail of $all tests failed"
	exit 1
fi
EOF

echo -e "\033[0;33mDONE\033[m"

if bash checkall; then
	cd $builddir
	rm -rf $testdir
else
	cd $builddir
	exit 1
fi

