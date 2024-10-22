#!/usr/bin/env fish

set -l to_sort
set -l grabbing false
while read -l line
    if string match -qe '[[son]]' "$line"
        echo "$line"
        set grabbing true
    else if string match -qe '[[soff]]' "$line"
        printf '%s\n' $to_sort | sort.py
        set to_sort
        echo "$line"
        set grabbing false
    else if $grabbing
        set to_sort $to_sort $line
    else
        echo "$line"
    end
end

if $grabbing
    printf '%s\n' $to_sort | sort.py
end
