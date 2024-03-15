#!/usr/bin/env fish

function update_layout
    set layout (get_layout)
    set capslock (get_capslock)
    if test $layout = English
        if test $capslock = on
            echo ENG
        else
            echo eng
        end
    else if test $layout = Russian
        if test $capslock = on
            echo RUS
        else
            echo rus
        end
    else
        echo idk
    end
end

while true
    widget_update update_layout Layout
    sleep 0.1
end
