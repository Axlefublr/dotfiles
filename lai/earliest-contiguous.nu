#!/usr/bin/env -S nu -n --no-std-lib

git log --format='"%an" %h'
| parse '"{author}" {hash}'
| take until { $in.author != Axlefublr }
| last
| get hash
