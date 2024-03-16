#!/usr/bin/env fish

function update_ram
    set used (free -h | awk '{ print $3 }')
    string trim --right --chars 'Gi' $used[2]
end

while true
    widget_update update_ram Ram
    sleep 3
end
