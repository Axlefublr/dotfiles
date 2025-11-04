#!/usr/bin/env fish

while true
    for file in ~/.local/share/magazine/(seq 1 9)
        test -s $file && printf (path basename $file)
    end
    echo
    inotifytheusual ~/.local/share/magazine/(seq 1 9)
end
