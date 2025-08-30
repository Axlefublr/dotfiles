#!/usr/bin/env fish

while true
    if test -s ~/.local/share/magazine/0
        cat ~/.local/share/magazine/0
    else
        echo
    end
    inotifywait -qq -e close_write -e move_self ~/.local/share/magazine/0
end
