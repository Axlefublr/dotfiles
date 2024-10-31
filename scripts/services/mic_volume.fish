#!/usr/bin/env fish

while true
    widget_update get_mic_volume Mic_volume
    if test "$battery_charge" -lt 100 &>/dev/null
        sleep 60
    else
        sleep 3
    end
end
