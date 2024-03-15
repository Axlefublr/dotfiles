#!/usr/bin/env fish

function update_bluetooth
    set is_on (get_bluetooth)
    if test $is_on = no
        echo ''
        return 0
    end
    set connection (get_bluetooth_connected 2> /dev/null)
    if test -z $connection
        echo disconnected
    else
        echo connected
    end
end

while true
    widget_update update_bluetooth Bluetooth
    sleep 0.1
end
