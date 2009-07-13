#!/bin/sh

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

ORIGDIR=`pwd`
cd $srcdir

test -z "$VALAC" && VALAC=valac
if ! $VALAC --version | sed -e 's/^.*\([0-9]\+\.[0-9]\+\)\.[0-9]\+.*$/\1/' | grep -vq '^0\.[0-6]$'
then
    echo "**Error**: You must have valac >= 0.7.0 installed"
    echo "  to build vala. Download the appropriate package"
    echo "  from your distribution or get the source tarball at"
    echo "  http://download.gnome.org/sources/vala/"
    exit 1
fi

# Automake requires that ChangeLog exist.
touch ChangeLog
mkdir -p m4

autoreconf -v --install || exit 1
cd $ORIGDIR || exit $?

$srcdir/configure --enable-maintainer-mode "$@"
