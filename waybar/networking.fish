#!/usr/bin/env fish

set -l the (nmcli networking connectivity)
test "$the" = full && echo || echo 󰖩
