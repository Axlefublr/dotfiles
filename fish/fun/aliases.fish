#!/usr/bin/env fish

# [[sort on]]
alias --save at alien_temple >/dev/null
alias --save bell 'printf \a' >/dev/null
alias --save copy 'wl-copy -n' >/dev/null
alias --save copyn wl-copy >/dev/null
alias --save e helix >/dev/null
alias --save etg 'propose.rs etg-active-items 50% ~/fes/foe/etg-active-items' >/dev/null
alias --save fc 'cat ~/fes/ack/fux/sudo | sudo -S systemctl restart fancontrol' >/dev/null
alias --save fm 'filter_mature_tasks | ov --column-mode --column-rainbow --column-width' >/dev/null
alias --save get_media_player 'playerctl metadata --format "{{playerName}}"' >/dev/null
alias --save get_media_time 'playerctl metadata --format "{{duration(position)}}"' >/dev/null
alias --save gx 'glaza --git' >/dev/null
alias --save gz glaza >/dev/null
alias --save hime 'history merge' >/dev/null
alias --save jf 'exec fish' >/dev/null
alias --save media_next 'playerctl next' >/dev/null
alias --save media_position 'playerctl position' >/dev/null
alias --save media_prev 'playerctl previous' >/dev/null
alias --save media_state 'playerctl status' >/dev/null
alias --save ntf_dismiss_all 'fnottctl dismiss all' >/dev/null
alias --save ntf_dismiss_old 'fnottctl dismiss' >/dev/null
alias --save reboot 'systemctl reboot' >/dev/null
alias --save set_media_volume 'playerctl volume' >/dev/null
alias --save set_mic_volume 'wpctl set-volume @DEFAULT_AUDIO_SOURCE@' >/dev/null
alias --save set_volume 'wpctl set-volume @DEFAULT_AUDIO_SINK@' >/dev/null
alias --save si copyi >/dev/null
alias --save sl copyl >/dev/null
alias --save sn copyn >/dev/null
alias --save sreboot 'systemctl soft-reboot' >/dev/null
alias --save suspend 'systemctl suspend' >/dev/null
alias --save toggle_media 'playerctl play-pause' >/dev/null
alias --save toggle_mic_mute 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle' >/dev/null
alias --save toggle_mute 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle' >/dev/null
alias --save ubootf 'footclient -T uboot uboot.fish' >/dev/null
alias --save woman man >/dev/null # lol and even lmao
alias --save ypoc 'wl-paste -n' >/dev/null
alias --save ypoci 'wl-paste -t image/png' >/dev/null
alias --save ypocn wl-paste >/dev/null
# [[sort off]]

function bl_reconnect
    if not test "$argv"
        echo 'missing bluetooth device MAC address' >&2
        return 1
    end
    bluetoothctl disconnect $argv
    bluetoothctl connect $argv
end
funcsave bl_reconnect >/dev/null

function clx
    if test "$TERM" = xterm-kitty
        printf '\e[H\e[22J'
        # else if test "$TERM" = foot
        #     return
    else
        clear -x
    end
end
funcsave clx >/dev/null

function copyi
    wl-copy -t image/png <$argv[1]
end
funcsave copyi >/dev/null

function copyl
    for filepath in $argv
        echo file://(path resolve $filepath)
    end | wl-copy -t text/uri-list
end
funcsave copyl >/dev/null

function cwd
    echo $PWD | copy
end
funcsave cwd >/dev/null

function eat
    loago do eat
    notify-send -t 2000 'ate!'
end
funcsave eat >/dev/null

function get_media_volume
    set volume (playerctl volume 2>/dev/null)
    if test -z "$volume"
        return 1
    end
    math "round($volume * 100)"
end
funcsave get_media_volume >/dev/null

function rdp
    set_color '#ffd75f'
    printf '󱕅 '
    set_color normal
end
funcsave rdp >/dev/null
