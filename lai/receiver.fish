#!/usr/bin/env fish

mkfifo ~/.local/share/mine/task-scheduler 2>/dev/null
set -l this_window_id (na -c 'niri msg -j windows | from json | where app_id starts-with foot | where title == "receiver" | get id | first')
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
        set -l first_word (string split ' ' $second)[1]
        function _receive_sigint --on-signal INT
        end
        fish -c $second </dev/tty
        set -l stored_status $status
        functions -e _receive_sigint
        if test $stored_status -eq 0
            set_color -o a9b665
            echo success
            set_color normal
            notify-send "✅ $first_word"
            echo
            break
        end
        set_color -o ea6962
        notify-send "❌ $first_word"
        niri msg action set-window-urgent --id $this_window_id
        confirm.rs failure '[r]estart' '[e]dit' '[k]ancel' | read -l response
        set_color normal
        echo
        if test $response = k
            break
        else if test $response = e
            set second (echo $second | vipe --suffix fish)
        end
    end
    cd ~
end
