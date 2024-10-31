#!/usr/bin/env fish

function battery_percentage
    acpi | string match -gr '(\\d+)%'
end

while true
    set -U battery_charge (battery_percentage)
    if test $battery_charge -le 5
        notify-send -t 0 'battery <= 5'
    end
    widget_update echo $battery_charge Charge
    sleep 30
end
