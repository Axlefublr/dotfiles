#!/usr/bin/env fish

while true
    for file in ~/.local/share/magazine/(seq 1 8)
        test -s $file && printf (path basename $file)
    end
    echo
    inotifywait -qq -e close_write ~/.local/share/magazine/(seq 1 8)
end
