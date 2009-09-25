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
srcdir=$PWD/`dirname $0`
topsrcdir=$srcdir/..
vapidir=$topsrcdir/vapi

export G_DEBUG=fatal_warnings

VALAC=$topbuilddir/compiler/valac
VALAFLAGS="--vapidir $vapidir --disable-warnings --main main --save-temps -X -O0 -X -pipe -X -lm"

function testheader() {
	if [ "$1" = "Packages:" ]; then
		shift
		PACKAGES="$PACKAGES $@"
		for pkg in "$@"; do
			if [ "$pkg" = "dbus-glib-1" ]; then
				echo 'eval `dbus-launch --sh-syntax`' >> prepare
				echo 'trap "kill $DBUS_SESSION_BUS_PID" INT TERM EXIT' >> prepare
			fi
		done
	fi
}

function sourceheader() {
	if [ "$1" = "Program:" ]; then
		testpath=${testfile/.test/}/$2
		ns=${testpath//\//.}
		ns=${ns//-/_}
		SOURCEFILE=$ns.vala
		SOURCEFILES="$SOURCEFILES $SOURCEFILE"
		echo "	case \"/$testpath\": $ns.main (); break;" >> main.vala
		echo "namespace $ns {" > $SOURCEFILE
	fi
}

function sourceend() {
	if [ -n "$testpath" ]; then
		echo "}" >> $SOURCEFILE
		echo "./test$EXEEXT /$testpath" > check
	fi
}

testdir=_test
rm -rf $testdir
mkdir $testdir
cd $testdir

echo -n -e "TEST: Building...\033[72G"

cat << "EOF" > checkall
all=0
fail=0
EOF

cat << "EOF" > main.vala
void main (string[] args) {
	switch (args[1]) {
EOF

PACKAGES=
SOURCEFILES=
for testfile in "$@"; do
	rm -f prepare check
	echo 'set -e' >> prepare

	case "$testfile" in
	*.vala)
		testpath=${testfile/.vala/}
		ns=${testpath//\//.}
		ns=${ns//-/_}
		SOURCEFILE=$ns.vala
		SOURCEFILES="$SOURCEFILES $SOURCEFILE"

		echo "	case \"/$testpath\": $ns.main (); break;" >> main.vala
		echo "namespace $ns {" > $SOURCEFILE
		cat "$srcdir/$testfile" >> $SOURCEFILE
		echo "}" >> $SOURCEFILE

		echo "./test$EXEEXT /$testpath" > check
		;;
	*.test)
		PART=0
		INHEADER=1
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
if bash $ns.check &>log; then
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

cat << "EOF" >> main.vala
	default: assert_not_reached ();
	}
}
EOF

cat $SOURCEFILES >> main.vala

if $VALAC $VALAFLAGS -o test$EXEEXT $(echo $PACKAGES | xargs -n 1 -r echo -n " --pkg") main.vala &>log; then
	echo -e "\033[0;32mOK\033[m"
else
	echo -e "\033[0;31mFAIL\033[m"
	cat log

	cd $builddir
	exit 1
fi

if bash checkall; then
	cd $builddir
	rm -rf $testdir
else
	cd $builddir
	exit 1
fi

