#!/usr/bin/env fish

function update_wifi
    set is_on (get_internet)
    if test $is_on = disabled
        echo ''
        return 0
    else
        get_internet_connection
    end
end

while true
    widget_update update_wifi Wifi
    sleep 0.1
end
