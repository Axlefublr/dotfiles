#!/usr/bin/env fish

while true
    widget_update get_media_time Media_time
    sleep 1
end &>/dev/null
