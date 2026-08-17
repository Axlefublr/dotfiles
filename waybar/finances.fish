#!/usr/bin/env fish

while true
    na ~/.local/share/magazine/o.nu | tee ~/fes/nak/↓money.txt
    inotifytheusual ~/.local/share/magazine/o ~/fes/nak/↑money.txt
end
