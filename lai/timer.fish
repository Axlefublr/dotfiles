#!/usr/bin/env fish

if not test "$argv"
    termdown
    return
end
for time_literal in $argv
    set -l time_seconds (calc -t "$time_literal to seconds" | string sub -e -2)
    termdown $time_seconds
end
