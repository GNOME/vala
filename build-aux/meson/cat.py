#!/usr/bin/env python3

import sys, os
from pathlib import Path

output_fd = sys.stdout.buffer.fileno()
for fname in sys.argv[1:]:
	inputf = Path(fname)
	with inputf.open('rb') as f:
		while os.sendfile(output_fd, f.fileno(), None, 1 << 30) != 0:
			pass
