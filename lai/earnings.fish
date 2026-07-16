#!/usr/bin/env fish

while true
    clear
    finance.nu data-wrapper
    ansi_cursor_hide
    inotifytheusual -t 3600 ~/.local/share/magazine/J ~/iwm/nak/↑earnings.txt ~/iwm/nak/↑desire.txt ~/.local/share/magazine/V
end
