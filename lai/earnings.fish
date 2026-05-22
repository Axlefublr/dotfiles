#!/usr/bin/env fish

while true
    clear
    finance.nu data
    ansi_hide_cursor
    inotifytheusual ~/ake/finances
end
