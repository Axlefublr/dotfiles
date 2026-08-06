#!/usr/bin/env fish

while true
    if test -s ~/.local/share/magazine/a
        echo (cat ~/.local/share/magazine/a)
    else
        echo
    end
    inotifytheusual ~/.local/share/magazine/a
end
