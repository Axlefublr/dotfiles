#!/usr/bin/env fish

while true
    inotifywait -q -e close_write -e move_self ~/.local/share/loago/loago.json
    filter_mature_tasks >~/.local/share/magazine/doublequote
    # awesome-client 'Hunger_wu()'
end
