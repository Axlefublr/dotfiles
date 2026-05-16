#!/usr/bin/env fish

set -l the (nmcli networking connectivity)
test "$the" = full -o "$the" = limited && echo || echo 󰖩
