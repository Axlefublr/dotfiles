#!/usr/bin/env fish

while true
    widget_update update_media_state Media_state
    if test "$(cat /dev/shm/Charge_f)" -lt 100 &>/dev/null
        sleep 60
    else
        sleep 1
    end
end &>/dev/null
