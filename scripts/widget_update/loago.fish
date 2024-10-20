#!/usr/bin/env fish

while true
    inotifywait -q -e close_write -e move_self ~/.local/share/loago/loago.json
    widget_update mature_tasks_line Loago
    awesome-client 'Hunger_wu()'
end
