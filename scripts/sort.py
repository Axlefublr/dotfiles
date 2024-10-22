#!/usr/bin/python

import sys

if len(sys.argv) < 2:
    lines = []
    for line in sys.stdin:
        lines.append(line)
    lines.sort()
    print(*lines, sep='', end='')
    exit(0)

path = sys.argv[1]

with open(path) as file:
    lines = file.readlines()

lines.sort()

with open(path, 'w') as file:
    file.writelines(lines)
