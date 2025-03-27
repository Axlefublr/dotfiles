#!/usr/bin/env fish

while true
    loago list -m eat | string match -gr '(\\d+)h (\\d+)m' | string join ':'
    inotifywait -t 60 -qq -e close_write ~/.local/share/loago/loago.json &>/dev/null
end
