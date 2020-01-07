#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
./autogen.sh --prefix=$DIR/local --disable-valadoc
