#!/usr/bin/env fish

function battery_percentage
    acpi | string match -gr '(\\d+)%'
end

while true
    set -U battery_charge (battery_percentage)
    widget_update echo $battery_charge Charge
    sleep 30
end
