#!/usr/bin/env fish

while true
    widget_update get_media_time Media_time
    if acpi | rg Discharging &>/dev/null
        sleep 60
    else
        sleep 1
    end
end &>/dev/null
