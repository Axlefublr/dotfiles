#!/usr/bin/env fish

while true
    widget_update update_wifi Wifi
    if test "$battery_charge" -lt 100 &>/dev/null
        sleep 5
    else
        sleep 1
    end
end
