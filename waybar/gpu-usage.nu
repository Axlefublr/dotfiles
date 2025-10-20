#!/usr/bin/env -S nu -n --no-std-lib

print ' 0'
radeontop -d - -i 10 | lines | skip 1 | each { str substring 30..33 | into float | math round | fill -w 2 -a r } | to text
