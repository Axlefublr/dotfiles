#!/usr/bin/python

import contextlib
import sys

unique = False

with contextlib.suppress(Exception):
    unique = sys.argv[1] == '-u'
    if unique:
        sys.argv.pop(1)

if len(sys.argv) < 1:
    lines = []
    for line in sys.stdin:
        lines.append(line)
    if unique:
        lines = sorted(set(lines))
    else:
        lines.sort()
    print(*lines, sep='', end='')
    exit(0)

path = sys.argv[1]

with open(path) as file:
    lines = file.readlines()

if unique:
    lines = sorted(set(lines))
else:
    lines.sort()

with open(path, 'w') as file:
    file.writelines(lines)
