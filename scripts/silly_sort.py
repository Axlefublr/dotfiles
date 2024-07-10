#!/usr/bin/python

import sys

if len(sys.argv) < 2:
    sys.stderr.write("No file to silly sort\n")
    exit(1)

path = sys.argv[1]

with open(path, 'r') as file:
    lines = file.readlines()

lines.sort()

with open(path, 'w') as file:
    file.writelines(lines)
