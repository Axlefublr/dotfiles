#!/usr/bin/env fish

set -g layout (keyboard_layout)
set -g capslock (capslock_state)

function figure_out
    if test $layout = 'English (US)'
        if test $capslock = 0
            echo en
        else
            echo EN
        end
    else if test $layout = Russian
        if test $capslock = 0
            echo ru
        else
            echo RU
        end
    else
        echo ??
    end
end

figure_out

function layout_switch -s SIGUSR1
    set layout (keyboard_layout)
    set capslock (capslock_state)
    figure_out
end

function capslock_toggle -s SIGUSR2
    set capslock (math bitxor 1, $capslock)
    figure_out
end

while true
    read
end
