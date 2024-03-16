#!/usr/bin/env fish

function update_processor
    set floating_percentage (mpstat | awk '$13 ~ /[0-9.]+/ { print 100 - $13 }')
    set rounded_percentage (math round $floating_percentage)
    echo $rounded_percentage
end

while true
    widget_update update_processor Processor
    sleep 3
end
