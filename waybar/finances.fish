#!/usr/bin/env fish

while true
    na ~/.local/share/magazine/o.nu | tee ~/iwm/nak/↓money.txt
    inotifytheusual ~/.local/share/magazine/o ~/iwm/nak/↑money.txt
end
