#!/usr/bin/env fish

while true
    clear
    finance.nu data
    echo
    desires.nu input (cat ~/iwm/nak/desire-input.txt) >>~/.local/share/magazine/V
    truncate -s 0 ~/iwm/nak/desire-input.txt
    desires.nu output | tee ~/iwm/nak/desire-output.txt
    ansi_hide_cursor
    inotifytheusual -t 3600 ~/ake/finances ~/iwm/nak/desire-input.txt ~/.local/share/magazine/V
end
