#!/usr/bin/env fish

while true
    widget_update update_bluetooth Bluetooth
    if acpi | rg Discharging &>/dev/null
        sleep 5
    else
        sleep 0.1
    end
end
