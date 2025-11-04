#!/usr/bin/env fish

while true
    loago list -m eat | string match -gr '(\\d+)h (\\d+)m' | string join ':'
    inotifytheusual -t 60 ~/.local/share/loago/loago.json &>/dev/null
end
