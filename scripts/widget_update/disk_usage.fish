#!/usr/bin/env fish

while true
    widget_update disk_usage Disk_usage
    if acpi | rg Discharging &>/dev/null
        sleep 60
    else
        sleep 3
    end
end
