#!/usr/bin/env fish

while true
    inotifywait -q -e close_write -e move_self ~/.local/share/loago/loago.json
    widget_update mature_tasks_line Loago
    awesome-client 'Hunger_wu()'
    set prevdir $PWD
    cd ~/prog/autocommit
    cp -f ~/.local/share/loago/loago.json .
    git add loago.json &>/dev/null
    and git commit -m "loago $argv" &>/dev/null
    cd $prevdir
end
