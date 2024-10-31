#!/usr/bin/env fish

while true
    inotifywait -qq -e close_write -e move_self ~/.local/share/magazine/(seq 0 9)
    awesome-client 'Registers_wu()'
end
