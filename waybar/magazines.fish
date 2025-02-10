#!/usr/bin/env fish

while true
    inotifywait -qq -e close_write ~/.local/share/magazine/(seq 1 9)
    for file in ~/.local/share/magazine/(seq 1 9)
        test -s $file && printf (path basename $file)
    end
    echo
end
