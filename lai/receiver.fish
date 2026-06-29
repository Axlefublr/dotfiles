#!/usr/bin/env fish

# make pressing ctrl+c only send it to the eventual `fish -c $second` process, not the entire script
function _receive_sigint --on-signal INT
    echo
end
rm -f ~/fes/zufi/tms/receiver-ongoing 2>/dev/null
mkfifo ~/fes/zufi/task-scheduler 2>/dev/null
set -l this_window_id (na -c 'niri msg -j windows | from json | where app_id starts-with foot | where title == "receiver" | get id | first')
# this bash wrapper (that *turns* into the direct tail process thanks to `exec`) protects `tail` from ctrl+c; without it, ctrl+c-ing `fish -c $second` *also* ctrl+c-s the tail, ending the listening loop, and requiring me to restart the receiver.fish window (and I think losing data?)
bash -c 'trap "" INT ; exec tail -f ~/fes/zufi/task-scheduler' | while read -z first
    and read -z second
    touch ~/fes/zufi/tms/receiver-ongoing
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
        fish -c $second </dev/tty
        set -l stored_status $status
        if test $stored_status -eq 0
            set_color -o a9b665
            echo success
            set_color normal
            notify-send "✅ $first_word"
            echo
            break
        end
        set_color -o (test $stored_status -eq 130 && echo e49641 || echo ea6962)
        notify-send "❌ $first_word"
        niri msg action set-window-urgent --id $this_window_id
        confirm.rs (test $stored_status -eq 130 && echo canceled || echo failure) '[r]estart' '[e]dit' 'pro[j]eed' | read -l response
        set_color normal
        echo
        if test $response = j
            break
        else if test $response = e
            set second (echo $second | vipe --suffix fish)
        end
    end
    cd ~
    rm -f ~/fes/zufi/tms/receiver-ongoing 2>/dev/null
end
