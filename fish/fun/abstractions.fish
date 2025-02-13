#!/usr/bin/env fish

alias --save ubootf 'kitty -T uboot uboot.fish' >/dev/null
alias --save media_state 'playerctl status' >/dev/null
alias --save media_next 'playerctl next' >/dev/null
alias --save media_prev 'playerctl previous' >/dev/null
alias --save media_position 'playerctl position' >/dev/null
function get_media_volume
    set volume (playerctl volume 2>/dev/null)
    if test -z "$volume"
        return 1
    end
    math "round($volume * 100)"
end
funcsave get_media_volume >/dev/null

function set_media_volume
    playerctl volume "$argv"
end
funcsave set_media_volume >/dev/null

function toggle_media
    playerctl play-pause
end
funcsave toggle_media >/dev/null

function get_media_time
    playerctl metadata --format '{{duration(position)}}'
end
funcsave get_media_time >/dev/null

function get_media_player
    playerctl metadata --format '{{playerName}}'
end
funcsave get_media_player >/dev/null

function get_media_title
    begin
        playerctl metadata --format '{{artist}}'
        playerctl metadata --format '{{title}}'
    end | string join ' — '
end
funcsave get_media_title >/dev/null

function ml
    media_position "$argv-"
end
funcsave ml >/dev/null

function mm
    media_position "$argv+"
end
funcsave ml >/dev/null

alias --save toggle_mute 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle' >/dev/null
alias --save toggle_mic_mute 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle' >/dev/null

function set_volume
    wpctl set-volume @DEFAULT_AUDIO_SINK@ $argv
end
funcsave set_volume >/dev/null

function set_mic_volume
    wpctl set-volume @DEFAULT_AUDIO_SOURCE@ $argv
end
funcsave set_mic_volume >/dev/null

function bl_reconnect
    if not test "$argv"
        echo 'missing bluetooth device MAC address' >&2
        return 1
    end
    bluetoothctl disconnect $argv
    bluetoothctl connect $argv
end
funcsave bl_reconnect >/dev/null

function ntf-dismiss-old
    fnottctl dismiss
end
funcsave ntf-dismiss-old >/dev/null

function ntf-pick-dismiss
    set -l result (fnottctl list | rg '^\\d' | fuzzel -d 2>/dev/null)
    test $status -ne 0 && return 1
    fnottctl dismiss (echo $result | string match -gr '^(\\d+)')
end
funcsave ntf-pick-dismiss >/dev/null

function clipboard-pick
    set -l result (cliphist list | tee ~/.cache/mine/cliphist | cut -f 2- | fuzzel -d --index)
    test $status -ne 0 && return 1
    sed -n (math $result + 1)'p' ~/.cache/mine/cliphist | cliphist decode | copy
end
funcsave clipboard-pick >/dev/null

function clipboard-index -a index
    notify-send -t 2000 "$(cliphist list | sed -n $index'p' | cliphist decode | pee 'wl-copy -n' 'head -c 100')"
end
funcsave clipboard-index >/dev/null

function toggle-screen-record
    if matches 'Title: "screen-record";App ID: "kitty"' &>/dev/null
        kitten @ --to unix:/home/axlefublr/.cache/mine/screen-record-kitty-socket signal-child SIGINT
    else
        kitty -T screen-record --listen-on unix:/home/axlefublr/.cache/mine/screen-record-kitty-socket screen-record.fish
    end
end
funcsave toggle-screen-record >/dev/null
