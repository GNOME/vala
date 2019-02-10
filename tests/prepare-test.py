#!/usr/bin/env python3

import sys, os, re
from pathlib import Path

if len(sys.argv) != 3:
	print("Wrong amount of parameters.")

inputf = Path(sys.argv[1])
outputf = Path(sys.argv[2])

with inputf.open('r') as ifile:
	with outputf.open('w') as ofile:
		if not ifile.readline().strip() == "Invalid Code":
			ifile.seek(0)
		lines = ifile.readlines()
		ofile.writelines(lines)
