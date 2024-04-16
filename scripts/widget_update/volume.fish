#!/usr/bin/env fish

while true
    widget_update get_volume Volume
    if acpi | rg Discharging &>/dev/null
        sleep 60
    else
        sleep 1
    end
end
