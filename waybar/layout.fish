#!/usr/bin/env fish

not test -p ~/.local/share/mine/waybar-layout && mkfifo ~/.local/share/mine/waybar-layout
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

function layout_switch
    set layout (keyboard_layout)
    set capslock (capslock_state)
    figure_out
end

function capslock_toggle
    set capslock (math bitxor 1, $capslock)
    figure_out
end

while cat ~/.local/share/mine/waybar-layout | read -L the
    echo $the | source
end
