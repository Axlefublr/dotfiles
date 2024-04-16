#!/usr/bin/env fish

while true
    widget_update update_wifi Wifi
    if acpi | rg Discharging &>/dev/null
        sleep 5
    else
        sleep 1
    end
end
