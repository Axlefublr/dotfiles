#!/usr/bin/env fish

function update_media_player
    set player (get_media_player 2>/dev/null)
    if not test "$player"
        return
    end
    if test $player = 'chromium'
        echo '󰌀'
    else if test $player = 'spotify'
        echo ''
    else
        echo '󰝚'
    end
end

while true
    widget_update update_media_player Media_player
    sleep 0.1
end
