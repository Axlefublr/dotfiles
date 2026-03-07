#!/usr/bin/env fish

while true
    cat ~/.local/share/mine/task-scheduler | while read -z first
        and read -z second
        if test $first != ~
            set_color -o b58cc6
            echo $first
            cd $first
        end
        while true
            set_color -o e491b2
            echo $second
            set_color normal
            fish -c $second </dev/tty
            if test $status -eq 0
                break
            end
            set_color -o d3ad5c
            confirm.rs "command failed" '[r]estart' '[e]dit' '[k]ancel' | read -l response
            set_color normal
            if test $response = k
                break
            else if test $response = e
                set second (echo $second | vipe --suffix fish)
            end
        end
        cd ~
    end
end
