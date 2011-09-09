#!/bin/sh

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

test -z "$VALAC" && VALAC=valac
if ! $VALAC --version | sed -e 's/^Vala \([0-9]\+\.[0-9]\+\).*$/\1/' | grep -vq '^0\.\([0-9]\|1[0-1]\)$'
then
    echo "**Error**: You must have valac >= 0.12.0 installed"
    echo "  to build vala. Download the appropriate package"
    echo "  from your distribution or get the source tarball at"
    echo "  http://download.gnome.org/sources/vala/"
    exit 1
fi

# Automake requires that ChangeLog exist.
touch ChangeLog
mkdir -p m4

rm -f .version
autoreconf -v --install || exit 1
cd $ORIGDIR || exit $?

if test -z "$NOCONFIGURE"; then
    $srcdir/configure "$@"
fi
