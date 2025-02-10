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

function toggle-screen-record
    if matches 'Title: "screen-record";App ID: "kitty"' &>/dev/null
        kitten @ --to unix:/home/axlefublr/bs/screen-record-kitty-socket signal-child SIGINT
    else
        kitty -T screen-record --listen-on unix:/home/axlefublr/bs/screen-record-kitty-socket screen-record.fish
    end
end
funcsave toggle-screen-record >/dev/null
