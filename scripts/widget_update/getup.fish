#!/usr/bin/env fish

while true
    sleep 10
    awesome-client 'Getup_we()'
    while not test -s /dev/shm/Getup_f
        sleep 5
    end
    truncate -s 0 /dev/shm/Getup_f
    awesome-client 'Getup_wd()'
end
