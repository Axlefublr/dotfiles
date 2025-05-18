#!/usr/bin/env fish

touch ~/.local/share/flipboard
while true
    inotifywait -qq -e close_write -e move_self ~/.local/share/flipboard
    cat ~/.local/share/flipboard | copy
    echo copied something >&2
end
