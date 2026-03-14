#!/usr/bin/env fish

while true
    finance.nu data
    inotifytheusual -t 43200 ~/ake/finances
end
