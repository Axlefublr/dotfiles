#!/usr/bin/env fish

tail -f ~/.local/share/mine/task-scheduler | while read -z first
    and read -z second
    if test $first != ~
        set_color -o b58cc6
        path_shrink $first
        cd $first
    end
    while true
        set_color -o e491b2
        echo $second
        set_color normal
        fish -c $second </dev/tty
        if test $status -eq 0
            set_color -o a9b665
            echo success
            set_color normal
            break
        end
        set_color -o ea6962
        confirm.rs failure '[r]estart' '[e]dit' '[k]ancel' | read -l response
        set_color normal
        if test $response = k
            break
        else if test $response = e
            set second (echo $second | vipe --suffix fish)
        end
    end
    cd ~
end
