#!/usr/bin/env fish

while true
    set -l groups (loago list -m eat | string match -gr '(\\d+)h (\\d+)m')
    set -l minutes (string pad -c 0 -w 2 $groups[2])
    echo $groups[1]:$minutes
    inotifytheusual -t 60 ~/.local/share/loago/loago.json &>/dev/null
end
