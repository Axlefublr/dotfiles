#!/usr/bin/env fish

while true
    if test -s ~/.local/share/magazine/0
        echo (cat ~/.local/share/magazine/0)
    else
        echo
    end
    inotifytheusual ~/.local/share/magazine/0
end
