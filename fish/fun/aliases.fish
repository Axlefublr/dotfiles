#!/usr/bin/env fish

# [[sort on]]
alias --save X 'kitten @ close-window' >/dev/null
alias --save at alien_temple >/dev/null
alias --save bell 'printf \a' >/dev/null
alias --save copy 'wl-copy -n' >/dev/null
alias --save copyn wl-copy >/dev/null
alias --save e helix >/dev/null
alias --save ezagit 'eza --git --git-repos' >/dev/null
alias --save get_media_player 'playerctl metadata --format "{{playerName}}"' >/dev/null
alias --save get_media_time 'playerctl metadata --format "{{duration(position)}}"' >/dev/null
alias --save gx 'glaza --git' >/dev/null
alias --save gz glaza >/dev/null
alias --save h 'z ~ && clx' >/dev/null
alias --save hime 'history merge' >/dev/null
alias --save jf 'clx && exec fish' >/dev/null
alias --save media_next 'playerctl next' >/dev/null
alias --save media_position 'playerctl position' >/dev/null
alias --save media_prev 'playerctl previous' >/dev/null
alias --save media_state 'playerctl status' >/dev/null
alias --save ntf-dismiss-all 'fnottctl dismiss all' >/dev/null
alias --save ntf-dismiss-old 'fnottctl dismiss' >/dev/null
alias --save o ypoc >/dev/null
alias --save s copy >/dev/null
alias --save set_media_volume 'playerctl volume' >/dev/null
alias --save set_mic_volume 'wpctl set-volume @DEFAULT_AUDIO_SOURCE@' >/dev/null
alias --save set_volume 'wpctl set-volume @DEFAULT_AUDIO_SINK@' >/dev/null
alias --save si copyi >/dev/null
alias --save sl copyl >/dev/null
alias --save sn copyn >/dev/null
alias --save suspend 'systemctl suspend' >/dev/null
alias --save toggle_media 'playerctl play-pause' >/dev/null
alias --save toggle_mic_mute 'wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle' >/dev/null
alias --save toggle_mute 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle' >/dev/null
alias --save ubootf 'kitty -T uboot uboot.fish' >/dev/null
alias --save woman man >/dev/null # lol and even lmao
alias --save ypoc 'wl-paste -n' >/dev/null
alias --save ypoci 'wl-paste -t image/png' >/dev/null
# [[sort off]]

function rdp
    set_color '#ffd75f'
    printf '󱕅 '
    set_color normal
end
funcsave rdp >/dev/null

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

function clx
    if test "$TERM" != xterm-kitty
        clear -x
    else
        printf '\e[H\e[22J'
    end
end
funcsave clx >/dev/null

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

function bl_reconnect
    if not test "$argv"
        echo 'missing bluetooth device MAC address' >&2
        return 1
    end
    bluetoothctl disconnect $argv
    bluetoothctl connect $argv
end
funcsave bl_reconnect >/dev/null
