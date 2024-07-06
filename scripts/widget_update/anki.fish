#!/usr/bin/env fish

while true
    widget_update update_anki Anki
    if test "$(cat /dev/shm/Charge_f)" -lt 100 &>/dev/null
        sleep 60
    else
        sleep 5
    end
end
