#!/usr/bin/env fish

while true
    widget_update update_bluetooth Bluetooth
    if test "$(cat /dev/shm/Charge_f)" -lt 100 &>/dev/null
        sleep 5
    else
        sleep 0.1
    end
end
