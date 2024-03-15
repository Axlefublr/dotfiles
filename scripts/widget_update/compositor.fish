#!/usr/bin/env fish

function update_compositor
    if pidof picom &>/dev/null
        echo ''
    else
        echo no
    end
end

while true
    widget_update update_compositor Compositor
    sleep 0.1
end
