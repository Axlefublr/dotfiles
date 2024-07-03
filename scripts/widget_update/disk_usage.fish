#!/usr/bin/env fish

while true
    widget_update disk_usage Disk_usage
    if test "$(cat /dev/shm/Charge_f)" -lt 100 &>/dev/null
        sleep 60
    else
        sleep 3
    end
end
