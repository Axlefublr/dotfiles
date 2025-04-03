#!/usr/bin/env fish

while true
    if test -s ~/.local/share/magazine/9
        cat ~/.local/share/magazine/9
    else
        echo
    end
    inotifywait -qq -e close_write -e move_self ~/.local/share/magazine/9
end
