#!/usr/bin/env fish

while true
    widget_update get_mic_volume Mic_volume
    if test "$(cat /dev/shm/Charge_f)" -lt 100 &>/dev/null
        sleep 60
    else
        sleep 1
    end
end
