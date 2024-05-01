#!/usr/bin/env fish

function update_battery
    acpi | string match -gr '(\\d+)%'
end

while true
    widget_update update_battery Charge
    sleep 10
end
