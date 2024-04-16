#!/usr/bin/env fish

while true
    widget_update get_mic_volume Mic_volume
    if acpi | rg Discharging &>/dev/null
        sleep 60
    else
        sleep 1
    end
end
