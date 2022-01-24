#! /usr/bin/env python3

# Generate libvala-0.xx.vapi from dependent vapi's

import os
import sys

def generate_libvala_vapi(argv):
    for f in argv[1:]:
        with open(f, 'r') as l:
            print(l.read())

sys.exit(generate_libvala_vapi(sys.argv))