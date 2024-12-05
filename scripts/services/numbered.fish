#!/usr/bin/env fish

while true
    inotifywait -qq -e close_write -e move_self ~/.local/share/magazine/(seq 1 9)
    awesome-client 'Registers_wu()'
end
