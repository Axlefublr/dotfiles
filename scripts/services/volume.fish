#!/usr/bin/env fish

while true
    widget_update get_volume Volume
    if test "$battery_charge" -lt 100 &>/dev/null
        sleep 60
    else
        sleep 1
    end
end