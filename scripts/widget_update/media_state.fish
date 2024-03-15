#!/usr/bin/env fish

function update_media_state
    set state (media_state)
    if test $state = Paused
        echo '󰏤'
    else if test $state = Playing
        echo '󰐊'
    else if test $state = Stopped
        echo '󰓛'
    else
        echo ''
    end
end

while true
    widget_update update_media_state Media_state
    sleep 0.1
end
